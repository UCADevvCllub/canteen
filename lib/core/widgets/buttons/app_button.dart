import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.borderColor,
    this.leadingIcon,
    this.text,
  });

  final String title;
  final VoidCallback onPressed;
  final Color? color;
  final Color? borderColor;
  final IconData? leadingIcon;
  final Widget? text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Determine the text color: if the background is white, use the borderColor (if provided) or a default color; otherwise, use white
    final textColor = (color == Colors.white && borderColor != null)
        ? borderColor!
        : Colors.white;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: color ?? theme.primaryColor,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null)
              Row(
                children: [
                  Icon(
                    leadingIcon,
                    color: textColor, // Use the same text color for the icon
                  ),
                  const SizedBox(width: 8.0),
                ],
              ),
            text == null
                ? Text(
              title,
              style: theme.textTheme.headlineSmall!.copyWith(
                color: textColor, // Use the calculated text color
                fontWeight: FontWeight.bold,
              ),
            )
                : text!,
          ],
        ),
      ),
    );
  }
}