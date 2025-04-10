import 'package:canteen/features/schedule/presentation/helpers/dialogs/note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:canteen/core/widgets/cards/message_bubble_background.dart';
import 'package:canteen/features/schedule/presentation/provider/schedule_provider.dart';
import 'package:provider/provider.dart';

class NoteSection extends StatefulWidget {
  const NoteSection({super.key});

  @override
  State<NoteSection> createState() => _NoteSectionState();
}

class _NoteSectionState extends State<NoteSection> with NoteDialog {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, scheduleProvider, _) {
        final isAdmin = scheduleProvider.isUserAdmin;
        final currentNote = scheduleProvider.note;

        return GestureDetector(
          onTap: () {
            if (isAdmin) {
              showNoteDialog(
                context: context,
                currentNote: currentNote,
              ).then((newNote) {
                if (newNote != null && newNote.isNotEmpty) {
                  scheduleProvider.updateNote(newNote);
                }
              });
            }
          },
          child: BubbleBackground(
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isAdmin) ...[
                    const Icon(
                      Icons.edit_note,
                      size: 30,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Flexible(
                    child: Text(
                      currentNote.isNotEmpty
                          ? currentNote
                          : "No note available.",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
