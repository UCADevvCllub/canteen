import 'package:flutter/material.dart';
import 'package:canteen/core/widgets/cards/message_bubble_background.dart';

class NoteWidget extends StatelessWidget {
  final String note;

  const NoteWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BubbleBackground(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text(
              note,
              style: const TextStyle(fontSize: 24, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
