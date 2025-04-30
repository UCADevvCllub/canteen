import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For TextInputFormatter

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.height,
    this.isPassword = false,
    this.maxLines = 1,
    this.borderColor,
    this.keyboardType,
    this.suffixText,
    this.inputFormatters, // Added inputFormatters property
  });

  final String hintText;
  final TextEditingController controller;
  final IconData? icon;
  final double? height;
  final bool isPassword;
  final int maxLines;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final String? suffixText;
  final List<TextInputFormatter>? inputFormatters; // Added property

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscureText : false,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters, // Use inputFormatters
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.grey[600],
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              prefixIcon: widget.icon != null
                  ? Icon(
                widget.icon,
                color: Colors.grey.shade600,
              )
                  : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey.shade500,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
                  : null,
              suffixText: widget.suffixText,
            ),
            maxLines: widget.maxLines,
          ),
        ),
      ],
    );
  }
}