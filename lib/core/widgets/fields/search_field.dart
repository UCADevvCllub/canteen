import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double? hintFontSize;
  final EdgeInsets? contentPadding;
  final bool showClearButton;
  final double? iconSize;

  const SearchField({
    super.key,
    required this.controller,
    this.hintText = 'Search product',
    this.hintFontSize = 16,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    this.showClearButton = true,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: hintFontSize, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        contentPadding: contentPadding,
        prefixIcon: Icon(Icons.search, color: Colors.grey, size: iconSize),
        suffixIcon: showClearButton && controller.text.isNotEmpty
            ? IconButton(
          icon: Icon(Icons.clear, color: Colors.grey, size: iconSize),
          onPressed: () => controller.clear(),
        )
            : null,
      ),
    );
  }
}