import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

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
      backgroundColor: AppColors.background(context),
      body: SafeArea(
        // SafeArea ensures content is not hidden behind system UI (status bar, notch, etc.)
        child: Center(
          child: SingleChildScrollView(
            // allows scrolling if content overflows vertically
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: ConstrainedBox(
              // limit maximum width for better readability on large screens
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // stretch children to fill width
                  mainAxisSize: MainAxisSize.min, // occupy only necessary vertical space
                  children: [
                    // --- HEADER SECTION ---
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // align text left
                      children: [
                        Text(
                          "Regisztráció", // page title
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text(context),
                          ),
                        ),
                        const SizedBox(height: 6), // spacing between title and subtitle
                        Text(
                          "Hozd létre a fiókodat", // subtitle/instruction
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.text(context).withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28), // spacing before form fields

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
                          Icons.email, // icon to indicate email input
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
                        // checks that email is not empty and contains '@'
                        if (value == null || value.isEmpty) {
                          return "Kérlek add meg az e-mail címed!";
                        }
                        if (!value.contains("@")) {
                          return "Nem érvényes e-mail cím.";
                        }
                        return null; // valid email
                      },
                    ),

                    const SizedBox(height: 16), // spacing

                    // --- PASSWORD INPUT FIELD ---
                    TextFormField(
                      obscureText: _obscurePassword, // hide input text if true
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
                          Icons.lock, // lock icon
                          color: AppColors.primary(context),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: AppColors.text(context).withValues(alpha: 0.7),
                          ),
                          onPressed: () {
                            // toggle password visibility
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
                        // validate password length and non-empty
                        if (value == null || value.isEmpty) {
                          return "Kérlek add meg a jelszavad!";
                        }
                        if (value.length < 6) {
                          return "A jelszó legalább 6 karakter legyen.";
                        }
                        return null; // valid password
                      },
                    ),

                    const SizedBox(height: 16), // spacing

                    // --- CONFIRM PASSWORD FIELD ---
                    TextFormField(
                      obscureText: _obscureConfirmPassword, // hide input text if true
                      style: TextStyle(
                        color: AppColors.text(context),
                      ),
                      cursorColor: AppColors.primary(context),
                      decoration: InputDecoration(
                        labelText: "Jelszó megerősítése", // confirm password label
                        labelStyle: TextStyle(
                          color: AppColors.text(context).withValues(alpha: 0.7),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColors.primary(context),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                            color: AppColors.text(context).withValues(alpha: 0.7),
                          ),
                          onPressed: () {
                            // toggle confirm password visibility
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
                        // validate that confirm password is not empty
                        if (value == null || value.isEmpty) {
                          return "Kérlek erősítsd meg a jelszavad!";
                        }
                        return null; // valid confirm password
                      },
                    ),

                    const SizedBox(height: 24), // spacing before register button

                    // --- REGISTER BUTTON ---
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          // validate form before processing registration
                          if (_formKey.currentState!.validate()) {
                            print("Regisztráció sikeres (demo)"); // demo action
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
                        child: const Text("Regisztráció"),
                      ),
                    ),

                    const SizedBox(height: 16), // spacing before login link

                    // --- LOGIN LINK ---
                    Align(
                      alignment: Alignment.centerRight, // align link to right
                      child: TextButton(
                        onPressed: () {
                          // navigate back to login page
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary(context),
                        ),
                        child: const Text("Már van fiókod? Bejelentkezés"),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // --- FOOTER (optional) ---
                    Center(
                      child: Text(
                        // shows current screen width × height for demo purposes
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
