part of '../widgets.dart';

class InputPassword extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String label;
  final String? Function(String? value)? validator;

  const InputPassword({
    Key? key,
    this.focusNode,
    this.controller,
    this.label = "Password",
    this.validator,
  }) : super(key: key);

  @override
  _InputPasswordState createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _obscureText = true;
  bool _isEmpty = true;

  void _updateInputState() {
    setState(() {
      print(widget.controller?.text.isEmpty);
      _isEmpty = widget.controller?.text.isEmpty ?? true;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_updateInputState);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_updateInputState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (widget.validator != null)
              const Text(
                '*',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
              ),
          ],
        ),
        const SizedBox(height: 2),
        TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: _obscureText,
          style: const TextStyle(fontSize: 14, color: Color(0xff0A0A0A)),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: CustomColors.primary, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1),
            ),
            suffixIcon: !_isEmpty
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
