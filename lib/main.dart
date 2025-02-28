import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/home/onboarding/onboarding_screen.dart';
import 'package:movies_app/providers/user_provider.dart';
import 'package:movies_app/theme/app%20theme.dart';
import 'package:movies_app/theme/theme.dart';
import 'package:provider/provider.dart';
import 'Login Screen/Login Screen.dart';
import 'Login Screen/forget_password.dart';
import 'Login Screen/register.dart';
import 'bloc/cubit.dart';
import 'firebase/firebase_options.dart';
import 'home/home.dart';
import 'home/tabs/profile tab/edit profile.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..getMoviesList()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: [
          const Locale('en'),
          const Locale('ar'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Themes theme = AppTheme();
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.routeName,
        theme: theme.themeData,
        routes: {
          OnboardingScreen.routeName: (context)=> OnboardingScreen(),
          UpdateProfileScreen.routeName: (context) => UpdateProfileScreen(),
          Home.routeName: (context) => Home(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          ForgetPassword.routeName: (context) => ForgetPassword(),
        }
    );
  }
}