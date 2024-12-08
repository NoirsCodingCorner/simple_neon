import 'package:flutter/material.dart';

/// A neon-styled text field with glowing effects and bidirectional binding support.
///
/// The `NeonTextField` widget provides a visually appealing text input field with
/// neon-style glowing borders and text. It synchronizes text between a `TextEditingController`
/// and a `ValueNotifier<String>`, enabling real-time updates.
///
/// This widget is ideal for modern UIs with futuristic or vibrant designs.
class NeonTextField extends StatefulWidget {
  /// Placeholder text displayed when the text field is empty. Default is "Enter text...".
  final String hintText;

  /// The color of the neon glow and border. Default is `Colors.cyan`.
  final Color neonColor;

  /// The intensity of the glow effect. Default is 16.0.
  final double blurRadius;

  /// A `ValueNotifier<String>` to synchronize the text value.
  final ValueNotifier<String> textValue;

  /// Creates a `NeonTextField` widget.
  ///
  /// The text field features a glowing neon border, real-time text synchronization,
  /// and customizable styles. [textValue] is required for bidirectional text binding.
  const NeonTextField({
    Key? key,
    this.hintText = "Enter text...",
    this.neonColor = Colors.cyan,
    this.blurRadius = 16.0,
    required this.textValue,
  }) : super(key: key);

  @override
  State<NeonTextField> createState() => _NeonTextFieldState();
}

class _NeonTextFieldState extends State<NeonTextField> {
  late final TextEditingController _controller;
  late final VoidCallback _controllerListener;
  late final VoidCallback _valueNotifierListener;
  bool _isUpdating = false; // Flag to prevent circular updates

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the current value of the ValueNotifier.
    _controller = TextEditingController(text: widget.textValue.value);

    // Listener to update the ValueNotifier when the controller text changes.
    _controllerListener = () {
      if (!_isUpdating) {
        _isUpdating = true;
        widget.textValue.value = _controller.text;
        _isUpdating = false;
      }
    };

    // Listener to update the controller text when the ValueNotifier changes.
    _valueNotifierListener = () {
      if (!_isUpdating && _controller.text != widget.textValue.value) {
        _isUpdating = true;
        _controller.text = widget.textValue.value;
        // Move cursor to the end after programmatic update.
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
        _isUpdating = false;
      }
    };

    // Add listeners to the controller and ValueNotifier.
    _controller.addListener(_controllerListener);
    widget.textValue.addListener(_valueNotifierListener);
  }

  @override
  void dispose() {
    // Remove listeners to prevent memory leaks.
    _controller.removeListener(_controllerListener);
    widget.textValue.removeListener(_valueNotifierListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Neon border effect
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: widget.blurRadius,
                color: widget.neonColor,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: widget.neonColor, // Solid neon color
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: widget.blurRadius,
                  color: Colors.black, // Inner shadow for contrast
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: TextField(
              controller: _controller,
              style: TextStyle(
                color: widget.neonColor, // Neon text color
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    blurRadius: widget.blurRadius,
                    color: widget.neonColor.withOpacity(0.6),
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: widget.neonColor.withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      blurRadius: widget.blurRadius,
                      color: widget.neonColor.withOpacity(0.6),
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                filled: true,
                fillColor: Colors.transparent, // Transparent background
                border: InputBorder.none, // Remove default Flutter border
              ),
            ),
          ),
        ),
      ],
    );
  }
}
