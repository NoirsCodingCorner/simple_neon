import 'package:flutter/material.dart';

/// A neon-styled text widget with optional animation and hover effects.
///
/// The `NeonText` widget provides a glowing text effect that can be customized
/// with size, color, weight, and animation. It also includes hover effects for web/desktop platforms.
class NeonText extends StatefulWidget {
  /// The text to display.
  final String text;

  /// The font size of the text. Default is 15.0.
  final double fontSize;

  /// Custom text style to override defaults. Default is null.
  final TextStyle? textStyle;

  /// The color of the neon glow. Default is `Colors.cyanAccent`.
  final Color neonColor;

  /// The intensity of the outer glow. Default is 20.0.
  final double glowRadius;

  /// The intensity of the inner blur effect. Default is 10.0.
  final double blurRadius;

  /// The font weight of the text. Default is `FontWeight.bold`.
  final FontWeight fontWeight;

  /// The text alignment. Default is `TextAlign.center`.
  final TextAlign textAlign;

  /// Whether to animate the glow effect. Default is `false`.
  final bool animate;

  /// Creates a `NeonText` widget.
  ///
  /// The widget features a glowing text with optional animation and hover effects.
  /// [text] is required. Other parameters are optional and have defaults.
  const NeonText({
    Key? key,
    required this.text,
    this.fontSize = 15.0,
    this.textStyle,
    this.neonColor = Colors.cyanAccent,
    this.glowRadius = 20.0,
    this.blurRadius = 10.0,
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.center,
    this.animate = false,
  }) : super(key: key);

  @override
  _NeonTextState createState() => _NeonTextState();
}

class _NeonTextState extends State<NeonText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isHovered = false; // For web/desktop hover effect

  @override
  void initState() {
    super.initState();
    // Initialize animation controller if animation is enabled.
    if (widget.animate) {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..repeat(reverse: true);

      _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Dispose the animation controller if it exists.
    if (widget.animate) {
      _animationController.dispose();
    }
    super.dispose();
  }

  /// Handles hover state for web/desktop platforms.
  void _onHover(bool hovering) {
    setState(() {
      _isHovered = hovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the base text style with shadows for the neon effect.
    TextStyle baseStyle = widget.textStyle ??
        TextStyle(
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          color: widget.neonColor,
          shadows: [
            Shadow(
              blurRadius: widget.blurRadius,
              color: widget.neonColor.withOpacity(0.8),
              offset: const Offset(0, 0),
            ),
            Shadow(
              blurRadius: widget.glowRadius,
              color: widget.neonColor.withOpacity(0.6),
              offset: const Offset(0, 0),
            ),
            Shadow(
              blurRadius: widget.glowRadius * 1.5,
              color: widget.neonColor.withOpacity(0.4),
              offset: const Offset(0, 0),
            ),
            Shadow(
              blurRadius: widget.glowRadius * 2,
              color: widget.neonColor.withOpacity(0.2),
              offset: const Offset(0, 0),
            ),
          ],
        );

    // Create the text widget.
    Widget textWidget = Text(
      widget.text,
      textAlign: widget.textAlign,
      style: baseStyle,
    );

    // Wrap the text with animation if enabled.
    if (widget.animate) {
      textWidget = AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: textWidget,
      );
    }

    // Wrap with MouseRegion for hover detection on web/desktop.
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 300),
        style: _isHovered
            ? baseStyle.copyWith(
          shadows: [
            Shadow(
              blurRadius: widget.blurRadius + 5,
              color: widget.neonColor.withOpacity(1.0),
              offset: const Offset(0, 0),
            ),
            Shadow(
              blurRadius: widget.glowRadius + 10,
              color: widget.neonColor.withOpacity(0.8),
              offset: const Offset(0, 0),
            ),
            Shadow(
              blurRadius: widget.glowRadius * 1.5 + 10,
              color: widget.neonColor.withOpacity(0.6),
              offset: const Offset(0, 0),
            ),
            Shadow(
              blurRadius: widget.glowRadius * 2 + 10,
              color: widget.neonColor.withOpacity(0.4),
              offset: const Offset(0, 0),
            ),
          ],
        )
            : baseStyle,
        child: textWidget,
      ),
    );
  }
}
