part of '../widgets.dart';

class EditNotePageModal extends StatelessWidget {
  final NoteModel note;

  const EditNotePageModal({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (_, __) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Scaffold(
            body: EditNotePage(note: note),
          ),
        );
      },
    );
  }
}
