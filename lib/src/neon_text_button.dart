import 'package:flutter/material.dart';

/// A neon-styled text button with glowing effects and press animation.
///
/// The `NeonTextButton` is a glowing, interactive button that features customizable
/// text, colors, glow effects, and press animations. It is suitable for vibrant and futuristic UI designs.
class NeonTextButton extends StatefulWidget {
  /// The text to display inside the button.
  final String text;

  /// The font size of the text. Default is 20.0.
  final double fontSize;

  /// Custom text style to override defaults. Default is null.
  final TextStyle? textStyle;

  /// The color of the neon glow. Default is `Colors.cyanAccent`.
  final Color neonColor;

  /// Callback triggered when the button is pressed.
  final VoidCallback onPressed;

  /// The intensity of the neon glow effect. Default is 20.0.
  final double glowRadius;

  /// Padding around the text inside the button. Default is 16.0.
  final double padding;

  /// Creates a `NeonTextButton` widget.
  ///
  /// The button displays glowing text with press animation and customizable styles.
  /// [text] and [onPressed] are required. Other parameters are optional and have defaults.
  const NeonTextButton({
    Key? key,
    required this.text,
    this.fontSize = 20.0,
    this.textStyle,
    this.neonColor = Colors.cyanAccent,
    required this.onPressed,
    this.glowRadius = 20.0,
    this.padding = 16.0,
  }) : super(key: key);

  @override
  _NeonTextButtonState createState() => _NeonTextButtonState();
}

class _NeonTextButtonState extends State<NeonTextButton> {
  bool _isPressed = false;

  /// Handles button press down event.
  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  /// Handles button press up event.
  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  /// Handles button press cancel event.
  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Transform.scale(
        // Apply a scaling effect when the button is pressed.
        scale: (_isPressed ? 0.95 : 1.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.padding,
            vertical: widget.padding / 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), // Rounded corners
            color: Colors.black.withOpacity(0.2), // Semi-transparent background
            boxShadow: [
              // Outer Glow
              BoxShadow(
                color: widget.neonColor.withOpacity(0.2),
                blurRadius: widget.glowRadius / 2,
                spreadRadius: 1,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Text(
            widget.text,
            style: widget.textStyle ??
                TextStyle(
                  color: widget.neonColor,
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: widget.glowRadius / 2,
                      color: widget.neonColor.withOpacity(0.7),
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
