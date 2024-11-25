import 'package:flutter/material.dart';

class RoleDropdown extends StatefulWidget {
  final void Function(String?) onChanged;

  const RoleDropdown({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<RoleDropdown> createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  String? selectedRole; // Selected role value
  final List<String> roleOptions = ['Student', 'Faculty', 'Staff']; // Role options

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedRole,
        hint: const Text(
          'Select Role',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        items: roleOptions.map((String role) {
          return DropdownMenuItem<String>(
            value: role,
            child: Text(
              role,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedRole = value;
          });
          widget.onChanged(value); // Notify parent widget
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.school, color: Colors.grey[600]),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.black),
        icon: Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
      ),
    );
  }
}
