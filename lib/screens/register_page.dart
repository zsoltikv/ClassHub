import 'package:flutter/material.dart';

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
      body: SafeArea(
        // SafeArea ensures content is not hidden behind system UI (status bar, notch, etc.)
        child: Center(
          child: SingleChildScrollView(
            // allows scrolling if content overflows vertically
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: ConstrainedBox(
              // limit maximum width for better readability on large screens
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // stretch children to fill width
                mainAxisSize: MainAxisSize.min, // occupy only necessary vertical space
                children: [
                  // --- HEADER SECTION ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // align text left
                    children: const [
                      Text(
                        "Regisztráció", // page title
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6), // spacing between title and subtitle
                      Text(
                        "Hozd létre a fiókodat", // subtitle/instruction
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28), // spacing before form fields

                  // --- EMAIL INPUT FIELD ---
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "E-mail",
                      prefixIcon: Icon(Icons.email), // icon to indicate email input
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
                    decoration: InputDecoration(
                      labelText: "Jelszó",
                      prefixIcon: const Icon(Icons.lock), // lock icon
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          // toggle password visibility
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
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
                    decoration: InputDecoration(
                      labelText: "Jelszó megerősítése", // confirm password label
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          // toggle confirm password visibility
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
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
                      child: const Text("Már van fiókod? Bejelentkezés"),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // --- FOOTER (optional) ---
                  Center(
                    child: Text(
                      // shows current screen width × height for demo purposes
                      'Képernyő: ${size.width.toStringAsFixed(0)} × ${size.height.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}