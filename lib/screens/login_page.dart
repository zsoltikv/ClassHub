import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // --- HEADER SECTION ---
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bejelentkezés",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text(context),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // --- EMAIL INPUT FIELD ---
                    TextFormField(
                      style: TextStyle(
                        color: AppColors.text(context),
                      ),
                      cursorColor: AppColors.primary(context),
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        labelStyle: TextStyle(
                          color: AppColors.text(context).withValues(alpha: 0.7),
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
                            color: AppColors.primary(context).withValues(alpha: 0.3),
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

                    // --- PASSWORD INPUT FIELD ---
                    TextFormField(
                      obscureText: _obscurePassword,
                      style: TextStyle(
                        color: AppColors.text(context),
                      ),
                      cursorColor: AppColors.primary(context),
                      decoration: InputDecoration(
                        labelText: "Jelszó",
                        labelStyle: TextStyle(
                          color: AppColors.text(context).withValues(alpha: 0.7),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColors.primary(context),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: AppColors.text(context).withValues(alpha: 0.7),
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
                            color: AppColors.primary(context).withValues(alpha: 0.3),
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

                    const SizedBox(height: 12),

                    // --- REMEMBER ME + FORGOT PASSWORD ---
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          activeColor: AppColors.primary(context),
                          checkColor: Colors.white,
                        ),
                        Text(
                          "Emlékezz rám",
                          style: TextStyle(
                            color: AppColors.text(context),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/forgot-password');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary(context),
                          ),
                          child: const Text("Elfelejtetted?"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // --- REGISTRATION LINK ---
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary(context),
                        ),
                        child: const Text("Regisztráció"),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --- LOGIN BUTTON ---
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print("Bejelentkezés sikeres (demo)");
                            print("Emlékezz rám: $_rememberMe");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary(context),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text("Bejelentkezés"),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // --- FOOTER ---
                    Center(
                      child: Text(
                        'Képernyő: ${size.width.toStringAsFixed(0)} × ${size.height.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.text(context).withValues(alpha: 0.6),
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
    );
  }
}
