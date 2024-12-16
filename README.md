# Simple Neon 2.0.0

A **Flutter package** featuring a collection of neon-styled widgets and a dynamic starry background, designed to create futuristic and visually striking user interfaces.

![Screenshot_2024-12-12_221711](https://github.com/user-attachments/assets/4de30107-2ea6-4921-b1b7-ddf4d3b488d9)

---

## ✨ Features

- **Neon-Styled Widgets**: Buttons, text fields, cards, containers, sliders, progress bars, and text with glowing effects.
- **Starry Background**: Includes animated stars and shooting stars for dynamic visual appeal.
- **Customizable Design**: Adjust glow intensity, colors, and other properties.
- **Ready-to-Use Components**: Pre-built widgets for seamless integration.
- **Cross-Platform**: Works perfectly on Android, iOS, web, and desktop.

---

## 🛠 Installation

Add the package to your `pubspec.yaml`:
```yaml
dependencies:
  simple_neon: ^2.0.0
```

Install it using the Flutter command:
```bash
flutter pub get
```

Import it into your project:
```dart
import 'package:simple_neon/simple_neon.dart';
```

---

## 🧩 Widgets Included

### 1. NeonButton
A glowing button with customizable icon, size, and color.

```dart
NeonButton(
  icon: Icons.star,
  onPressed: () {
    print("Neon Button Pressed!");
  },
  neonColor: Colors.cyanAccent,
  size: 60.0,
);
```

---

### 2. NeonCard
A container with a neon-glowing border for grouping widgets.

```dart
NeonCard(
  neonColor: Colors.pinkAccent,
  children: [
    NeonText(text: "Welcome to Neon World!", neonColor: Colors.greenAccent),
    NeonTextButton(
      text: "Get Started",
      onPressed: () {},
      neonColor: Colors.blueAccent,
    ),
  ],
);
```

---

### 3. NeonContainer
A fully customizable neon container with adjustable width, height, glow radius, and border radius.

```dart
NeonContainer(
  width: 200.0,
  height: 100.0,
  neonColor: Colors.cyanAccent,
  glowRadius: 20.0,
  child: Center(
    child: NeonText(text: "Inside NeonContainer"),
  ),
);
```

---

### 4. NeonProgressBar
A progress indicator that can be segmented and glows with neon colors.

```dart
NeonProgressBar(
  progress: 0.5, // value between 0 and 1
  neonColor: Colors.greenAccent,
  height: 20.0,
);
```

---

### 5. NeonSlider
A neon-styled slider with optional segmentation, perfect for volume or brightness controls.

```dart
NeonSlider(
  value: 0.3, // value between 0 and 1
  neonColor: Colors.orangeAccent,
  onChanged: (newValue) {
    print("Slider value: $newValue");
  },
);
```

---

### 6. NeonText
Glowing text with customizable font size, style, and optional animations.

```dart
NeonText(
  text: "Futuristic Text",
  fontSize: 30,
  neonColor: Colors.greenAccent,
);
```

---

### 7. NeonTextButton
A neon-styled button with press animations and hover effects.

```dart
NeonTextButton(
  text: "Click Me",
  onPressed: () {
    print("Neon Text Button Clicked!");
  },
  neonColor: Colors.orangeAccent,
);
```

---

### 8. NeonTextField
A text input field with a neon-styled border and adjustable glow intensity.

```dart
NeonTextField(
  textValue: _emailController,
  hintText: "Enter your email",
  neonColor: Colors.pinkAccent,
);
```

---

### 9. PulsingStarsBackground
A dynamic background with pulsing stars and occasional shooting stars for a truly futuristic ambience.

```dart
PulsingStarsBackground(
  maxStars: 100,
  spawnDuration: const Duration(milliseconds: 500),
  spawnShootingStarDuration: const Duration(seconds: 10),
);
```

---

## 🚀 Example Usage

### Authentication Page with Neon Widgets
This package includes an example `AuthPage` widget that demonstrates the integration of neon-styled components in a Login/Register form.

```dart
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

```

---

## 📸 Screenshots

### Login Form

![Screenshot 2024-12-08 174529](https://github.com/user-attachments/assets/88cf0089-5e40-4117-affe-848136e9a570)

### Registration Form

![Screenshot 2024-12-08 174600](https://github.com/user-attachments/assets/816ed51b-9a05-4995-9de2-befa5a85c5e2)

### Starry Background
![Recording2024-12-08175046-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/eaaae196-67e5-4dd4-8915-5da14b5dbcae)

---

## 🛠 Customization

### Change Neon Colors
Easily change the neon glow color by setting the `neonColor` property:
```dart
NeonText(
  text: "Custom Text",
  neonColor: Colors.blueAccent,
);
```

### Adjust Glow Intensity
Modify `blurRadius` or `glowRadius` for softer or brighter effects:
```dart
NeonTextField(
  textValue: _emailController,
  blurRadius: 20.0,
  neonColor: Colors.cyanAccent,
);
```

---

## 📜 License

This package is open-source and available under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## ❤️ Support

If you find this package helpful, please consider giving it a star ⭐ on GitHub and sharing it with others!

---
