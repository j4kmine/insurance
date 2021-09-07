import 'dart:async';

import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/di/components/app_component.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/accident/accident_store.dart';
import 'package:boilerplate/stores/document/document_store.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/login/login_store.dart';
import 'package:boilerplate/stores/motor/motor_store.dart';
import 'package:boilerplate/stores/servicing/servicing_store.dart';
import 'package:boilerplate/stores/vehicle/vehicle_store.dart';
import 'package:boilerplate/stores/register/register_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/stores/warranty/warranty_store.dart';
import 'package:boilerplate/ui/app/app.dart';
import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*
  await firebaseMessaging.requestPermissions(
    const IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: false),
  );
  Clipboard.setData(
      new ClipboardData(text: await firebaseMessaging.getToken()));
firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {});*/
  StripePayment.setOptions(StripeOptions(
      publishableKey: Strings.stripeKey,
      merchantId: "CarFren",
      androidPayMode: 'CreditCard'));

  await setPreferredOrientations();
  await setupLocator();
  return runZonedGuarded(() async {
    runApp(MyApp());
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final VehicleStore _vehicleStore = VehicleStore(getIt<Repository>());
  final WarrantyStore _warrantyStore = WarrantyStore(getIt<Repository>());
  final MotorStore _motorStore = MotorStore(getIt<Repository>());
  final ServicingStore _servicingStore = ServicingStore(getIt<Repository>());
  final AccidentStore _accidentStore = AccidentStore(getIt<Repository>());
  final DocumentStore _documentStore = DocumentStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>());
  final RegisterStore _registerStore = RegisterStore(getIt<Repository>());
  final LoginStore _loginStore = LoginStore(getIt<Repository>());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<VehicleStore>(create: (_) => _vehicleStore),
        Provider<WarrantyStore>(create: (_) => _warrantyStore),
        Provider<MotorStore>(create: (_) => _motorStore),
        Provider<ServicingStore>(create: (_) => _servicingStore),
        Provider<AccidentStore>(create: (_) => _accidentStore),
        Provider<DocumentStore>(create: (_) => _documentStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<RegisterStore>(create: (_) => _registerStore),
        Provider<LoginStore>(create: (_) => _loginStore),
        Provider<UserStore>(create: (_) => _userStore)
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode ? themeDataDark : themeData,
            routes: Routes.routes,
            locale: Locale(_languageStore.locale),
            supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale, language.code))
                .toList(),
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            home: _userStore.isLoggedIn ? AppScreen() : LoginScreen(),
          );
        },
      ),
    );
  }
}
