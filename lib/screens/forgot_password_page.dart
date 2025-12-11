import 'package:flutter/material.dart';

// this is the forgot password screen widget, it allows the user to enter their email
// to initiate a password reset process
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // key to manage form validation
  final _formKey = GlobalKey<FormState>();

  // controller to access the email input text
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // get screen size for responsive layout

    return Scaffold(
      body: SafeArea(
        // SafeArea ensures content does not overlap system UI elements
        child: Center(
          child: SingleChildScrollView(
            // allows scrolling if content overflows vertically
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: ConstrainedBox(
              // limit the maximum width for readability
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // --- HEADER SECTION ---
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Jelszó visszaállítása", // page title
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Add meg az e-mail címed, hogy visszaállíthasd a jelszavad", // description
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28), // spacing before form

                  // --- EMAIL INPUT FIELD ---
                  TextFormField(
                    controller: _emailController, // binds input text to the controller
                    decoration: const InputDecoration(
                      labelText: "E-mail",
                      prefixIcon: Icon(Icons.email), // icon to indicate email field
                    ),
                    validator: (value) {
                      // checks if input is not empty and contains '@'
                      if (value == null || value.isEmpty) {
                        return "Kérlek add meg az e-mail címed!";
                      }
                      if (!value.contains("@")) {
                        return "Nem érvényes e-mail cím.";
                      }
                      return null; // valid input
                    },
                  ),

                  const SizedBox(height: 24), // spacing before button

                  // --- SUBMIT BUTTON ---
                  SizedBox(
                    height: 48, // fixed height for button
                    child: ElevatedButton(
                      onPressed: () {
                        // validate the form before processing
                        if (_formKey.currentState!.validate()) {
                          // here you would normally call backend to send reset email
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Jelszó visszaállító e-mail elküldve: ${_emailController.text}",
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text("Küldés"),
                    ),
                  ),

                  const SizedBox(height: 16), // spacing before login link

                  // --- LOGIN LINK ---
                  Align(
                    alignment: Alignment.centerRight, // align to right
                    child: TextButton(
                      onPressed: () {
                        // navigate back to login page
                        Navigator.pop(context);
                      },
                      child: const Text("Vissza a Bejelentkezéshez"),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // --- FOOTER (optional) ---
                  Center(
                    child: Text(
                      // shows the current screen dimensions for demo purposes
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