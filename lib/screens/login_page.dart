import 'package:flutter/material.dart';

// this is the main login page widget, it is stateful because it needs to manage
// form validation state, password visibility, and the 'remember me' checkbox state
class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageScreen> {
  // a key to identify the form and allow validation checks
  final _formKey = GlobalKey<FormState>();

  // controls whether the password field hides the text or not
  bool _obscurePassword = true;

  // stores the state of the 'remember me' checkbox (true if checked)
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    // retrieve the size of the device screen to allow responsive layout adjustments
    final size = MediaQuery.of(context).size;

    // Scaffold provides the basic visual structure: app bar, body, floating button, etc.
    return Scaffold(
      body: SafeArea(
        // SafeArea ensures content does not overlap system UI elements like notch or status bar
        child: Center(
          child: SingleChildScrollView(
            // allows vertical scrolling for smaller devices or landscape orientation
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: ConstrainedBox(
              // restricts the maximum width for better readability on large screens (e.g., web)
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // stretches children to fill width
                mainAxisSize: MainAxisSize.min, // only use as much vertical space as needed
                children: [
                  // --- HEADER SECTION ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // align text to the left
                    children: const [
                      Text(
                        "Bejelentkezés", // page title
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28), // spacing between header and form fields

                  // --- EMAIL INPUT FIELD ---
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "E-mail", // label shown inside the input when empty
                      prefixIcon: Icon(Icons.email), // icon at the start of the field
                    ),
                    // validator function checks if the email is valid
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Kérlek add meg az e-mail címed!"; // error message if empty
                      }
                      if (!value.contains("@")) {
                        return "Nem érvényes e-mail cím."; // error message if not a valid email format
                      }
                      return null; // return null if input is valid
                    },
                  ),

                  const SizedBox(height: 16), // spacing between fields

                  // --- PASSWORD INPUT FIELD ---
                  TextFormField(
                    obscureText: _obscurePassword, // hides the input text if true
                    decoration: InputDecoration(
                      labelText: "Jelszó",
                      prefixIcon: const Icon(Icons.lock), // lock icon at start of the field
                      // suffix icon to toggle password visibility
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          // toggle password visibility when pressed
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    // validator checks that password is not empty and minimum length
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Kérlek add meg a jelszavad!"; // error if empty
                      }
                      if (value.length < 6) {
                        return "A jelszó legalább 6 karakter legyen."; // error if too short
                      }
                      return null; // valid password
                    },
                  ),

                  const SizedBox(height: 12), // spacing

                  // --- REMEMBER ME CHECKBOX AND FORGOT PASSWORD LINK ---
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe, // current state of the checkbox
                        onChanged: (value) {
                          // update state when user taps the checkbox
                          setState(() {
                            _rememberMe = value ?? false; // default to false if null
                          });
                        },
                      ),
                      const Text("Emlékezz rám"), // label for the checkbox
                      const Spacer(), // pushes the next widget to the far right
                      TextButton(
                        onPressed: () {
                          // navigate to the forgot password page when clicked
                          Navigator.pushNamed(context, '/forgot-password');
                        },
                        child: const Text("Elfelejtetted?"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // --- REGISTRATION LINK ---
                  Align(
                    alignment: Alignment.centerRight, // align link to the right
                    child: TextButton(
                      onPressed: () {
                        // navigate to the registration page when clicked
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text("Regisztráció"),
                    ),
                  ),

                  const SizedBox(height: 24), // spacing before login button

                  // --- LOGIN BUTTON ---
                  SizedBox(
                    height: 48, // fixed height for button
                    child: ElevatedButton(
                      onPressed: () {
                        // validate the form before processing login
                        if (_formKey.currentState!.validate()) {
                          // print demo messages (replace with actual login logic)
                          print("Bejelentkezés sikeres (demo)");
                          print("Emlékezz rám: $_rememberMe");
                        }
                      },
                      child: const Text("Bejelentkezés"),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // --- FOOTER ---
                  Center(
                    child: Text(
                      // displays the current screen width and height (for demo purposes)
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