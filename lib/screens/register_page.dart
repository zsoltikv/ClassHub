import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/starry_background.dart'; // import the animated starry background

// this is the registration page widget, where a new user can create an account
// it is stateful because it needs to manage password visibility and form validation
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // key to manage form validation
  final _formKey = GlobalKey<FormState>();

  // controls whether the password is hidden or visible
  bool _obscurePassword = true;

  // controls whether the confirm password field is hidden or visible
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // get screen size for responsive layout

    return Scaffold(
      body: Stack(
        children: [
          // --- STAR BACKGROUND ---  
          const StarryBackground(), // háttér a legalsó rétegben

          // --- REGISTRATION FORM ---  
          SafeArea(
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
                              "Regisztráció",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: AppColors.text(context),
                                shadows: [
                                  Shadow(
                                    color: Colors.white.withOpacity(0.4), // a glow színe
                                    blurRadius: 8, // mennyire legyen homályos a glow
                                    offset: Offset(0, 0), // eltolás, 0,0 = középen
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Hozd létre a fiókodat",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.text(context).withOpacity(0.6),
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
                              color: AppColors.text(context).withOpacity(0.7),
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
                              color: AppColors.text(context).withOpacity(0.7),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.primary(context),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: AppColors.text(context).withOpacity(0.7),
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
                              return "Kérlek add meg a jelszavad!";
                            }
                            if (value.length < 6) {
                              return "A jelszó legalább 6 karakter legyen.";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // --- CONFIRM PASSWORD FIELD ---
                        TextFormField(
                          obscureText: _obscureConfirmPassword,
                          style: TextStyle(
                            color: AppColors.text(context),
                          ),
                          cursorColor: AppColors.primary(context),
                          decoration: InputDecoration(
                            labelText: "Jelszó megerősítése",
                            labelStyle: TextStyle(
                              color: AppColors.text(context).withOpacity(0.7),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.primary(context),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                                color: AppColors.text(context).withOpacity(0.7),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
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
                              return "Kérlek erősítsd meg a jelszavad!";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        // --- REGISTER BUTTON ---
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print("Regisztráció sikeres (demo)");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary(context),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              "Regisztráció",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // --- LOGIN LINK ---
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

                        // --- FOOTER ---
                        Center(
                          child: Text(
                            'Képernyő: ${size.width.toStringAsFixed(0)} × ${size.height.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.text(context).withOpacity(0.6),
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
}