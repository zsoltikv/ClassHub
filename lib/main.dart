import 'package:classhubweb/screens/forgot_password_page.dart';
import 'package:classhubweb/screens/login_page.dart';
import 'package:classhubweb/screens/register_page.dart';
import 'package:classhubweb/theme/app_theme.dart';
import 'package:flutter/material.dart';

// main entry point of the app
void main() {
  runApp(const MyApp()); // run the app with MyApp widget
}

// main app widget, stateless because it does not manage internal state
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClassHub', // app title
      debugShowCheckedModeBanner: false, // remove the debug banner

      // theming for the app with custom font globally
      theme: AppTheme.light.copyWith(
        textTheme: AppTheme.light.textTheme.apply(
          fontFamily: 'Montserrat', // ← custom font applied everywhere
        ),
      ),
      darkTheme: AppTheme.dark.copyWith(
        textTheme: AppTheme.dark.textTheme.apply(
          fontFamily: 'Montserrat', // ← same for dark theme
        ),
      ),
      themeMode: ThemeMode.system, // use system theme mode (light/dark)

      // initial route when the app starts
      initialRoute: '/login',

      // define named routes for navigation
      routes: {
        '/login': (context) => const LoginPageScreen(), // login page route
        '/register': (context) => const RegisterScreen(), // registration page route
        '/forgot-password': (context) => const ForgotPasswordScreen(), // forgot password route
      },
    );
  }
}
