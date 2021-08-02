import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  Repository? repository;
  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _LoginStore(Repository repository) {
    this.repository = repository;
  }

  // store variables:-----------------------------------------------------------
  @observable
  String verificationId = '';

  @observable
  String userNRIC = '';

  @observable
  String userPhone = '';

  @observable
  bool submitted = false;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @action
  Future login(BuildContext context, String userNRIC, String userPhone) async {
    loading = true;
    submitted = false;
    this.userNRIC = userNRIC;
    this.userPhone = userPhone;

    final future = repository!.check(userNRIC, userPhone);
    future.then((check) async {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: userPhone,
        verificationCompleted: (PhoneAuthCredential credential) {
          success = true;
          submitOTP(context, credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          loading = false;
          success = false;
          errorStore.errorMessage =
              AppLocalizations.of(context)!.translate("google_verification");
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
          loading = false;
          success = true;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          loading = false;
          success = false;
          // errorStore.errorMessage = AppLocalizations.of(context)!.translate("otp_timeout");
        },
      );
    }).catchError((error) {
      loading = false;
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future sendOTP(BuildContext context, String userOTP) async {
    loading = true;
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: userOTP);
    submitOTP(context, phoneAuthCredential);
  }

  // general methods:-----------------------------------------------------------
  void submitOTP(
      BuildContext context, PhoneAuthCredential phoneAuthCredential) async {
    try {
      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      final idToken = await result.user!.getIdToken();
      final future = repository!.login(idToken, userNRIC, userPhone);
      future.then((access) {
        loading = false;
        submitted = true;
      }).catchError((error) {
        loading = false;
        errorStore.errorMessage = DioErrorUtil.handleError(error);
      });
    } catch (exception) {
      loading = false;
      errorStore.errorMessage =
          AppLocalizations.of(context)!.translate("google_verification");
    }
  }
}
