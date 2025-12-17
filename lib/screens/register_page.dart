import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/starry_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  bool _obscureConfirmPassword = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          const StarryBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Regisztráció",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: AppColors.text(context),
                                shadows: [
                                  Shadow(
                                    color: Colors.white.withValues(alpha: 0.4),
                                    blurRadius: 8,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Hozd létre a fiókodat",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.text(
                                  context,
                                ).withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        TextFormField(
                          controller: _emailController,
                          style: TextStyle(color: AppColors.text(context)),
                          cursorColor: AppColors.primary(context),
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: AppColors.text(
                                context,
                              ).withValues(alpha: 0.7),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: AppColors.primary(context),
                            ),
                            filled: true,
                            fillColor: AppColors.inputBackground(context),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary(
                                  context,
                                ).withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary(context),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Kérlek add meg az e-mail címed!";
                            }
                            if (!value.contains("@")) {
                              return "Nem érvényes e-mail cím.";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: TextStyle(color: AppColors.text(context)),
                          cursorColor: AppColors.primary(context),
                          decoration: InputDecoration(
                            labelText: "Jelszó",
                            labelStyle: TextStyle(
                              color: AppColors.text(
                                context,
                              ).withValues(alpha: 0.7),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.primary(context),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.text(
                                  context,
                                ).withValues(alpha: 0.7),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: AppColors.inputBackground(context),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary(
                                  context,
                                ).withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary(context),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Kérlek add meg a jelszavad!";
                            }
                            if (value.length < 6) {
                              return "A jelszó legalább 6 karakter legyen.";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          obscureText: _obscureConfirmPassword,
                          style: TextStyle(color: AppColors.text(context)),
                          cursorColor: AppColors.primary(context),
                          decoration: InputDecoration(
                            labelText: "Jelszó megerősítése",
                            labelStyle: TextStyle(
                              color: AppColors.text(
                                context,
                              ).withValues(alpha: 0.7),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.primary(context),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.text(
                                  context,
                                ).withValues(alpha: 0.7),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: AppColors.inputBackground(context),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary(
                                  context,
                                ).withValues(alpha: 0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary(context),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Kérlek erősítsd meg a jelszavad!";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _register();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary(context),
                              foregroundColor: AppColors.inputBackground(
                                context,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              "Regisztráció",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primary(context),
                            ),
                            child: const Text("Már van fiókod? Bejelentkezés"),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Center(
                          child: Text(
                            'Képernyő: ${size.width.toStringAsFixed(0)} × ${size.height.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.text(
                                context,
                              ).withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _register() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text;

  final url = Uri.parse('http://188.36.204.175:8080/api/register');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userName': "", 
        'email': email,
        'password': password,
        'rememberMe': true
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Sikeres regisztráció');
    } else {
      print('Hiba: ${response.body}');
    }
  } catch (e) {
    print('Hálózati hiba: $e');
  }
}

@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
}

}