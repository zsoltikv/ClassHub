import 'package:classhubweb/screens/forgot_password_page.dart';
import 'package:classhubweb/screens/login_page.dart';
import 'package:classhubweb/screens/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  // entry point of the flutter application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // material app is the root widget of the application
    return MaterialApp(
      title: 'Flutter Demo', // the title of the application, used by the OS
      debugShowCheckedModeBanner: false, // removes the debug banner in the top-right corner
      theme: ThemeData(
        // define the color scheme of the app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true, // enable Material Design 3 styling
      ),
      initialRoute: '/login', // the first screen that will be displayed when the app starts
      routes: {
        // define named routes for navigation within the app
        '/login': (context) => const LoginPageScreen(), // main login page
        '/register': (context) => const RegisterScreen(), // user registration page
        '/forgot-password': (context) => const ForgotPasswordScreen(), // page to reset forgotten password
      },
    );
  }
}