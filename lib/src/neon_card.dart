import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A customizable neon-styled card with glowing effects and child widgets.
///
/// The `NeonCard` is a container with a neon glowing border, suitable for displaying grouped
/// widgets in a visually appealing way. It provides customizable neon colors and supports
/// additional styling through optional parameters.
class NeonCard extends StatelessWidget {
  /// The list of child widgets displayed inside the card.
  final List<Widget> children;

  /// The color of the neon glow and border.
  final Color neonColor;

  /// The border radius for rounded corners. Default is 8.0.
  final double borderRadius;

  /// The border width for the neon outline. Default is 2.0.
  final double borderWidth;

  /// The padding inside the card. Default is `EdgeInsets.all(8.0)`.
  final EdgeInsets padding;

  /// The intensity of the neon glow. Default is 16.0.
  final double blurRadius;

  /// Creates a `NeonCard` widget.
  ///
  /// The card features a glowing neon border with customizable child widgets and styling.
  ///
  /// [children] and [neonColor] are required. Other parameters are optional and have default values.
  const NeonCard({
    Key? key,
    required this.children,
    required this.neonColor,
    this.borderRadius = 8.0,
    this.borderWidth = 2.0,
    this.padding = const EdgeInsets.all(8.0),
    this.blurRadius = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: neonColor,
          width: borderWidth,
        ),
        boxShadow: [
          // Outer neon glow
          BoxShadow(
            color: neonColor.withOpacity(0.8),
            blurRadius: blurRadius,
            spreadRadius: 1.0,
            offset: Offset.zero,
          ),
          // Inner dark shadow
          BoxShadow(
            color: Colors.black.withOpacity(1.0),
            blurRadius: blurRadius,
            spreadRadius: 1.0,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Shrink to fit children
        children: children,
      ),
    );
  }
}
