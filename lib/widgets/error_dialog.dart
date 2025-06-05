part of 'widgets.dart';

void errorDialog(BuildContext context, Object e) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Error"),
      content: Text(e.toString().replaceAll('Exception: ', '')),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
