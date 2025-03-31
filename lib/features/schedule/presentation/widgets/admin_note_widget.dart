import 'package:flutter/material.dart';

class AdminNoteWidget extends StatelessWidget {
  final String noteText;
  final TextEditingController controller;
  final VoidCallback onSaved;

  const AdminNoteWidget({
    super.key,
    required this.noteText,
    required this.controller,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Edit Note"),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: "Enter note"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  onSaved();
                  Navigator.pop(context);
                },
                child: Text("Save"),
              ),
            ],
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/chatplus.png', width: 20, height: 20),
                SizedBox(width: 8),
                Text(
                  noteText,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
