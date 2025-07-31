import 'package:assignment_04/controller_binder.dart';
import 'package:assignment_04/ui/screens/add_new_task_screen.dart';
import 'package:assignment_04/ui/screens/change_password_screen.dart';
import 'package:assignment_04/ui/screens/forgot_password_email_screen.dart';
import 'package:assignment_04/ui/screens/main_navbar_holder_screen.dart';
import 'package:assignment_04/ui/screens/pin_verification_screen.dart';
import 'package:assignment_04/ui/screens/sign_in_screen.dart';
import 'package:assignment_04/ui/screens/sign_up_screen.dart';
import 'package:assignment_04/ui/screens/splash_screen.dart';
import 'package:assignment_04/ui/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),

          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(vertical: 12),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green
          )
        )
      ),
      initialRoute: '/',
      routes: {
        SplashScreen.name : (context) => SplashScreen(),
        SignInScreen.name : (context) => SignInScreen(),
        SignUpScreen.name : (context) => SignUpScreen(),
        ForgotPasswordEmailScreen.name : (context) => ForgotPasswordEmailScreen(),
        PinVerificationScreen.name : (context) => PinVerificationScreen(),
        ChangePasswordScreen.name : (context) => ChangePasswordScreen(),
        MainNavbarHolderScreen.name : (context) => MainNavbarHolderScreen(),
        AddNewTaskScreen.name : (context) => AddNewTaskScreen(),
        UpdateProfileScreen.name : (context) => UpdateProfileScreen(),
      },
      initialBinding: ControllerBinder(),
    );
  }
}
