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
              Icon(
                leadingIcon,
                color: Colors.white,
              ),
            const SizedBox(width: 8.0),
            text == null ? Text(
              title,
              style: theme.textTheme.headlineSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ) : text!,
          ],
        ),
      ),
    );
  }
}
