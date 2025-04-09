import 'package:canteen/features/schedule/presentation/provider/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:canteen/core/widgets/buttons/app_button.dart';
import 'package:provider/provider.dart';

mixin NoteDialog<T extends StatefulWidget> on State<T> {
  Future<String?> showNoteDialog({
    required BuildContext context,
    required String currentNote,
  }) {
    final noteController = TextEditingController(text: currentNote);

    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Note',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: noteController,
                  decoration: const InputDecoration(
                    hintText: 'Enter new note',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                AppButton(
                  title: 'Update Note',
                  onPressed: () {
                    final newNote = noteController.text.trim();
                    Provider.of<ScheduleProvider>(context, listen: false)
                        .updateNote(newNote);
                    Navigator.pop(ctx, newNote);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
