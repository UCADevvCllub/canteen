import 'package:flutter/material.dart';

/// BubbleBackground is a reusable widget that provides a styled bubble-like background
/// for any content passed as a child. It includes options for customizing the background color,
/// text color, and shadows.
class BubbleBackground extends StatelessWidget {
  final Widget child; // The content inside the bubble
  final Color backgroundColor; // The background color of the bubble
  final Color textColor; // The text color within the bubble
  final bool isSender; // Whether the bubble is for the sender or receiver
  final bool tail; // Whether the bubble includes a tail
  final double opacity; // Opacity of the background color

  const BubbleBackground({
    super.key,
    required this.child,
    this.backgroundColor = const Color(0xFF1E1E1E), // Default color
    this.textColor = Colors.white,
    this.isSender = false,
    this.tail = false,
    this.opacity = 0.5, // Default opacity is fully opaque
  })  : assert(opacity >= 0.0 && opacity <= 1.0, 'Opacity must be between 0 and 1.');

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(opacity), // Apply opacity here
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(isSender ? 15 : 0),
            bottomRight: Radius.circular(isSender ? 0 : 15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: DefaultTextStyle(
          style: TextStyle(color: textColor, fontSize: 14),
          child: child,
        ),
      ),
    );
  }
}