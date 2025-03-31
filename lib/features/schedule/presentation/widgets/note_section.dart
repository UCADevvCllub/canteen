import 'package:flutter/material.dart';
import 'package:canteen/features/schedule/presentation/helpers/schedule_dialogs.dart';

class NoteSection extends StatelessWidget {
  final String noteText;
  final TextEditingController controller;
  final ValueChanged<String> onNoteChanged;

  const NoteSection({
    super.key,
    required this.noteText,
    required this.controller,
    required this.onNoteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ScheduleDialogs.showEditNoteDialog(
        context: context,
        controller: controller,
        onSave: onNoteChanged,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/chatplus.png',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              Text(
                noteText,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}