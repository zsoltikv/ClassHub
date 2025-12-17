import 'package:classhubweb/screens/forgot_password_page.dart';
import 'package:classhubweb/screens/login_page.dart';
import 'package:classhubweb/screens/register_page.dart';
import 'screens/main_page.dart';
import 'package:classhubweb/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClassHub',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.light.copyWith(
        textTheme: AppTheme.light.textTheme.apply(fontFamily: 'Montserrat'),
      ),
      darkTheme: AppTheme.dark.copyWith(
        textTheme: AppTheme.dark.textTheme.apply(fontFamily: 'Montserrat'),
      ),
      themeMode: ThemeMode.system,

      initialRoute: '/login',

      routes: {
        '/login': (context) => const LoginPageScreen(),
        '/register': (context) => RegisterScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/main-page': (context) => MainPageScreen(),
      },
    );
  }
}