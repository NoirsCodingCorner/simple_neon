
// Assuming these custom widgets are defined elsewhere in your project
// import 'neon_widgets.dart'; // Replace with your actual import path

import 'package:flutter/material.dart';
import 'package:simple_neon/simple_neon.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // State variable to track whether the user is on the login or registration form
  bool _isLogin = true;

  // Controllers for text fields (optional but recommended)
  final ValueNotifier<String> _email = ValueNotifier("");
  final ValueNotifier<String> _password = ValueNotifier("");
  final ValueNotifier<String> _username = ValueNotifier("");
  final ValueNotifier<String> _confirmPassword = ValueNotifier("");

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed
    _email.dispose();
    _password.dispose();
    _username.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  // Function to toggle between login and registration forms
  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  // Function to handle form submission (Login/Register)
  Future<void> _handleSubmit() async {
    if (_isLogin) {
      // Handle login logic

      // Add your login logic here
    } else {
      // Handle registration logic
      String password = _password.value.trim();
      String confirmPassword = _confirmPassword.value.trim();

      if (password != confirmPassword) {
        // Show error if passwords do not match
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Passwords do not match!"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Add your registration logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PulsingStarsBackground(
            spawnDuration: const Duration(milliseconds: 50),
            maxStars: 50,
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(20.0),
                child: NeonCard(
                  neonColor: Colors.pinkAccent,
                  children: [
                    // Title Text
                    NeonText(
                      text: _isLogin ? "Welcome back!" : "Create Account",
                      fontSize: 30,
                      neonColor: Colors.greenAccent,
                    ),
                    const SizedBox(height: 20),

                    // If Registration Form, show Username Field
                    if (!_isLogin) ...[
                      NeonTextField(
                        textValue: _username,
                        hintText: "Username",
                        neonColor: Colors.greenAccent,
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Email Field
                    NeonTextField(
                      textValue: _email,
                      hintText: "Email",
                      neonColor: Colors.greenAccent,
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    NeonTextField(
                      textValue: _password,
                      hintText: "Password",
                      neonColor: Colors.greenAccent,
                    ),
                    const SizedBox(height: 20),

                    // If Registration Form, show Confirm Password Field
                    if (!_isLogin) ...[
                      NeonTextField(
                        textValue: _confirmPassword,
                        hintText: "Confirm Password",
                        neonColor: Colors.greenAccent,
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Submit Button (Login/Register)
                    NeonTextButton(
                      text: _isLogin ? "Login" : "Register",
                      onPressed: _handleSubmit,
                      neonColor: Colors.greenAccent,
                    ),
                    const SizedBox(height: 20),

                    // Toggle between Login and Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NeonText(
                          text: _isLogin
                              ? "No account? No problem, make one today: "
                              : "Already have an account? ",
                          fontSize: 13,
                          neonColor: Colors.greenAccent,
                          fontWeight: FontWeight.w300,
                        ),
                        NeonTextButton(
                          text: _isLogin ? "Register" : "Back to Login",
                          onPressed: _toggleForm,
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.cyanAccent,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
