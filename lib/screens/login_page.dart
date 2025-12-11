import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/starry_background.dart'; // import the animated starry background

// login page screen as a stateful widget to handle user interactions
class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageScreen> {
  // global key to identify the form and validate it
  final _formKey = GlobalKey<FormState>();

  // boolean to toggle password visibility
  bool _obscurePassword = true;

  // boolean for the 'remember me' checkbox
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    // get screen size for responsive design or debugging
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // --- STAR BACKGROUND ---
          const StarryBackground(), // animated starry background

          // --- LOGIN FORM ---
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Form(
                    key: _formKey, // attach form key for validation
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // --- HEADER SECTION ---
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // main title text
                            Text(
                              "Bejelentkezés",
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
                          ],
                        ),

                        const SizedBox(height: 28), // spacing after header

                        // --- EMAIL INPUT FIELD ---
                        TextFormField(
                          style: TextStyle(
                            color: AppColors.text(context), // text color
                          ),
                          cursorColor: AppColors.primary(context), // cursor color
                          decoration: InputDecoration(
                            labelText: "E-mail", // label text
                            labelStyle: TextStyle(
                              color: AppColors.text(context).withOpacity(0.7), // label color with opacity
                            ),
                            prefixIcon: Icon(
                              Icons.email, // email icon
                              color: AppColors.primary(context),
                            ),
                            filled: true,
                            fillColor: AppColors.inputBackground(context), // input background color
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), // rounded corners
                              borderSide: BorderSide(
                                color: AppColors.primary(context).withOpacity(0.3), // light border
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary(context), // border when focused
                                width: 2,
                              ),
                            ),
                          ),
                          // validator for email input
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Kérlek add meg az e-mail címed!"; // required message
                            }
                            if (!value.contains("@")) {
                              return "Nem érvényes e-mail cím."; // invalid email message
                            }
                            return null; // input is valid
                          },
                        ),

                        const SizedBox(height: 16), // spacing

                        // --- PASSWORD INPUT FIELD ---
                        TextFormField(
                          obscureText: _obscurePassword, // hide password characters
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
                              Icons.lock, // lock icon
                              color: AppColors.primary(context),
                            ),
                            // toggle password visibility button
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: AppColors.text(context).withOpacity(0.7),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword; // toggle password visibility
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
                          // validator for password input
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Kérlek add meg a jelszavad!"; // required message
                            }
                            if (value.length < 6) {
                              return "A jelszó legalább 6 karakter legyen."; // minimum length
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        // --- REMEMBER ME + FORGOT PASSWORD ---
                        Row(
                          children: [
                            // checkbox for 'remember me'
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                              activeColor: AppColors.primary(context),
                              checkColor: Colors.black,
                            ),
                            Text(
                              "Emlékezz rám",
                              style: TextStyle(
                                color: AppColors.text(context),
                              ),
                            ),
                            const Spacer(), // pushes the next button to the right
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/forgot-password'); // navigate to forgot password
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.primary(context),
                              ),
                              child: const Text("Elfelejtetted?"), // forgot password text
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // --- LOGIN BUTTON ---
                        SizedBox(
                          height: 48, // button height
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // demo login success print statements
                                print("Bejelentkezés sikeres (demo)");
                                print("Emlékezz rám: $_rememberMe");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary(context),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2, // subtle shadow
                            ),
                            child: const Text(
                              "Bejelentkezés",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // --- REGISTRATION LINK ---
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register'); // navigate to registration page
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primary(context),
                            ),
                            child: const Text("Még nincs fiókod? Regisztráció"),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // --- FOOTER ---
                        Center(
                          child: Text(
                            // display current screen width and height for debug/demo
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