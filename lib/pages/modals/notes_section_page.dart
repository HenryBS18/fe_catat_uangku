part of '../pages.dart';

class NotesSectionModal extends StatelessWidget {
  final String initialNote;

  const NotesSectionModal({super.key, required this.initialNote});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: initialNote);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (_, controllerScroll) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Scaffold(
            backgroundColor: const Color(0xFFF7F7F7),
            appBar: AppBar(
              backgroundColor: const Color(0xFF0F55C3),
              title: const Text(
                'Catatan',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller,
                maxLength: 250,
                maxLines: 7,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) => Navigator.pop(context, value),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Tambahkan catatan tambahan...'),
              ),
            ),
          ),
        );
      },
    );
  }
}
