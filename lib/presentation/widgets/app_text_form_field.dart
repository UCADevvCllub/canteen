import 'package:flutter/material.dart';

//TODO: Give comments on every part of the code
class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.validator,
    this.height,
    this.isPassword = false,
    this.maxLines = 1,
  });

  final String hintText;
  final TextEditingController controller;
  final IconData? icon;
  final String? Function(String?)? validator;
  final double? height;
  final bool isPassword;
  final int maxLines;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey[600],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          prefixIcon: widget.icon != null ? Icon(widget.icon, color: Colors.grey[600]) : null,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
        ),
        maxLines: widget.maxLines,
      ),
    );
  }
}
