import 'package:flutter/material.dart';
import 'package:canteen/core/widgets/cards/message_bubble_background.dart';

class NoteSection extends StatelessWidget {
  final bool isAdmin;
  final String currentNote;
  final TextEditingController noteController;
  final VoidCallback onEditNote;

  const NoteSection({
    super.key,
    required this.isAdmin,
    required this.currentNote,
    required this.noteController,
    required this.onEditNote,
  });

  @override
  Widget build(BuildContext context) {
    return isAdmin ? _buildAdminNoteSection() : _buildUserNoteDisplay();
  }

  Widget _buildAdminNoteSection() {
    return GestureDetector(
      onTap: onEditNote,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/chatplus.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              'Add note',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF020202),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserNoteDisplay() {
    return BubbleBackground(
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Text(
          "Note: $currentNote",
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}