import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/starry_background.dart'; // import the animated starry background

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // --- STAR BACKGROUND ---
          const StarryBackground(), // háttér a legalsó rétegben

          // --- FORGOT PASSWORD FORM ---
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
                        // --- HEADER ---
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jelszó visszaállítása",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text(context),
                                letterSpacing: 1.5,
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
                              "Add meg az e-mail címed, hogy visszaállíthasd a jelszavad",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.text(context).withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // --- EMAIL FIELD ---
                        TextFormField(
                          controller: _emailController,
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

                        const SizedBox(height: 24),

                        // --- SUBMIT BUTTON ---
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: AppColors.primary(context),
                                    content: Text(
                                      "Jelszó visszaállító e-mail elküldve: ${_emailController.text}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
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
                              "Küldés",
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
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primary(context),
                            ),
                            child: const Text("Vissza a Bejelentkezéshez"),
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