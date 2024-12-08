# Simple Neon

A **Flutter package** featuring a collection of neon-styled widgets and a dynamic starry background, designed to create futuristic and visually striking user interfaces.

![Demo Screenshot](insert-demo-screenshot-path-here)

---

## ✨ Features

- **Neon-Styled Widgets**: Buttons, text fields, cards, and text with glowing effects.
- **Starry Background**: Includes animated stars and shooting stars for dynamic visual appeal.
- **Customizable Design**: Adjust glow intensity, colors, and other properties.
- **Ready-to-Use Components**: Pre-built widgets for seamless integration.
- **Cross-Platform**: Works perfectly on Android, iOS, web, and desktop.

---

## 🛠 Installation

Add the package to your `pubspec.yaml`:
```yaml
dependencies:
  neon_widgets: ^1.0.0
```

Install it using the Flutter command:
```bash
flutter pub get
```

Import it into your project:
```dart
import 'package:neon_widgets/neon_widgets.dart';
```

---

## 🧩 Widgets Included

### 1. NeonButton
A glowing button with customizable size and color.

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

### 3. NeonText
Glowing text with customizable font size and animations.

```dart
NeonText(
  text: "Futuristic Text",
  fontSize: 30,
  neonColor: Colors.greenAccent,
);
```

---

### 4. NeonTextButton
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

### 5. NeonTextField
An input field with a neon-styled border.

```dart
NeonTextField(
  textValue: _emailController,
  hintText: "Enter your email",
  neonColor: Colors.pinkAccent,
);
```

---

### 6. PulsingStarsBackground
A dynamic background with pulsing stars and occasional shooting stars.

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
class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PulsingStarsBackground(),
          Center(
            child: NeonCard(
              neonColor: Colors.blueAccent,
              children: [
                NeonText(text: "Welcome Back!", fontSize: 24),
                NeonTextField(
                  textValue: _emailController,
                  hintText: "Email",
                  neonColor: Colors.greenAccent,
                ),
                NeonTextField(
                  textValue: _passwordController,
                  hintText: "Password",
                  neonColor: Colors.greenAccent,
                ),
                NeonTextButton(
                  text: "Login",
                  onPressed: () {},
                  neonColor: Colors.greenAccent,
                ),
              ],
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
![Login Form](insert-login-screenshot-path-here)

### Registration Form
![Registration Form](insert-registration-screenshot-path-here)

### Starry Background
![Starry Background](insert-starry-background-screenshot-path-here)

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
```
