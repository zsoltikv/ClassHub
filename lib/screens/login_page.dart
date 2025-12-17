import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main_page.dart';
import '../theme/app_colors.dart';
import '../widgets/starry_background.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;

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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Bejelentkezés",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: AppColors.text(context),
                            shadows: [
                              Shadow(
                                color: Colors.white.withOpacity(0.4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        TextFormField(
                          controller: _usernameController,
                          style: TextStyle(color: AppColors.text(context)),
                          cursorColor: AppColors.primary(context),
                          decoration: InputDecoration(
                            labelText: "Felhasználónév",
                            labelStyle: TextStyle(
                              color: AppColors.text(context).withOpacity(0.7),
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: AppColors.primary(context),
                            ),
                            filled: true,
                            fillColor: AppColors.inputBackground(context),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary(context).withOpacity(0.3),
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
                              return "Kérlek add meg a felhasználóneved!";
                            }
                            if (value.length < 3) {
                              return "A felhasználónév legalább 3 karakter legyen.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Password field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: TextStyle(color: AppColors.text(context)),
                          cursorColor: AppColors.primary(context),
                          decoration: InputDecoration(
                            labelText: "Jelszó",
                            labelStyle: TextStyle(color: AppColors.text(context).withOpacity(0.7)),
                            prefixIcon: Icon(Icons.lock, color: AppColors.primary(context)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: AppColors.text(context).withOpacity(0.7),
                              ),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            filled: true,
                            fillColor: AppColors.inputBackground(context),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppColors.primary(context).withOpacity(0.3)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppColors.primary(context), width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Kérlek add meg a jelszavad!";
                            if (value.length < 6) return "A jelszó legalább 6 karakter legyen.";
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        // Remember me checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) => setState(() => _rememberMe = value ?? false),
                              activeColor: AppColors.primary(context),
                              checkColor: AppColors.inputBackground(context),
                            ),
                            Text("Emlékezz rám", style: TextStyle(color: AppColors.text(context))),
                            const Spacer(),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
                              style: TextButton.styleFrom(foregroundColor: AppColors.primary(context)),
                              child: const Text("Elfelejtetted?"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Login button
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _login(); 
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary(context),
                              foregroundColor: AppColors.inputBackground(context),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 2,
                            ),
                            child: const Text("Bejelentkezés", style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/register'),
                            style: TextButton.styleFrom(foregroundColor: AppColors.primary(context)),
                            child: const Text("Még nincs fiókod? Regisztráció"),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            'Képernyő: ${size.width.toStringAsFixed(0)} × ${size.height.toStringAsFixed(0)}',
                            style: TextStyle(fontSize: 12, color: AppColors.text(context).withOpacity(0.6)),
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

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final url = Uri.parse('http://188.36.204.175:8080/api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userName': username,
          'password': password,
          'rememberMe': _rememberMe,
        }),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainPageScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hiba: ${response.body}'), duration: const Duration(seconds: 2)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hálózati hiba: $e'), duration: const Duration(seconds: 2)),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}