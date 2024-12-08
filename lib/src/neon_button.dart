import 'package:flutter/material.dart';

/// A customizable neon-styled button with glowing effects.
///
/// This button widget provides a circular glowing appearance and a scaling animation when pressed.
/// It supports custom icons, sizes, colors, and glow intensities, making it suitable for
/// futuristic or vibrant UI designs.
class NeonButton extends StatefulWidget {
  /// The icon displayed at the center of the button.
  final IconData icon;

  /// The size of the button (width and height). Default is 60.0.
  final double size;

  /// The color of the neon glow. Default is `Colors.cyanAccent`.
  final Color neonColor;

  /// Callback triggered when the button is pressed.
  final VoidCallback onPressed;

  /// The radius of the glowing effect. Default is 20.0.
  final double glowRadius;

  /// Whether the button has a shadow behind it. Default is `true`.
  final bool showShadow;

  /// Opacity of the button's background. Default is 0.2.
  final double backgroundOpacity;

  /// Scale factor applied when the button is pressed. Default is 0.9.
  final double pressedScale;

  /// Creates a [NeonButton] widget.
  ///
  /// The button is a circular widget with a neon glow, designed for aesthetic UIs.
  ///
  /// [icon] and [onPressed] are required. Other parameters are optional and have defaults.
  const NeonButton({
    super.key,
    required this.icon,
    this.size = 60.0,
    this.neonColor = Colors.cyanAccent,
    required this.onPressed,
    this.glowRadius = 20.0,
    this.showShadow = true,
    this.backgroundOpacity = 0.2,
    this.pressedScale = 0.9,
  });

  @override
  _NeonButtonState createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
  }

  /// Handles the button press down event.
  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  /// Handles the button press up event.
  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  /// Handles the button press cancel event.
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
        // Apply scaling based on press state.
        scale: (_isPressed ? widget.pressedScale : 1.0),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Circular shape
            color: Colors.black.withOpacity(widget.backgroundOpacity), // Background opacity
            boxShadow: widget.showShadow
                ? [
              // Outer Glow effect
              BoxShadow(
                color: widget.neonColor.withOpacity(0.3),
                blurRadius: widget.glowRadius * 2,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              ),
            ]
                : null,
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: widget.neonColor,
              size: widget.size * 0.5, // Icon size relative to button size
            ),
          ),
        ),
      ),
    );
  }
}
