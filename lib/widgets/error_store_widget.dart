import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ErrorStoreWidget extends StatelessWidget {
  final ErrorStore? errorStore;
  const ErrorStoreWidget({Key? key, this.errorStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (errorStore!.errorMessage.isNotEmpty) {
          Future.delayed(Duration(milliseconds: 0), () {
            if (errorStore!.errorMessage != null &&
                errorStore!.errorMessage.isNotEmpty) {
              FlushbarHelper.createError(
                message: errorStore!.errorMessage,
                title: AppLocalizations.of(context)!.translate('home_tv_error'),
                duration: Duration(seconds: 3),
              )..show(context);
            }
          });
        }
        return SizedBox.shrink();
      },
    );
  }
}
