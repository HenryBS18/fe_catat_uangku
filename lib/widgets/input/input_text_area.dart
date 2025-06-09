part of '../widgets.dart';

class InputTextArea extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final String? hint;
  final bool border;
  final int maxLines;
  final String? initialValue;
  final bool disable;
  final FocusNode? focusNode;
  final String? Function(String? value)? validator;

  const InputTextArea({
    Key? key,
    this.label,
    this.controller,
    this.hint,
    this.border = true,
    required this.maxLines,
    this.initialValue,
    this.disable = false,
    this.focusNode,
    this.validator,
  }) : super(key: key);

  @override
  State<InputTextArea> createState() => _InputTextAreaState();
}

class _InputTextAreaState extends State<InputTextArea> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (widget.label != null)
              Text(
                widget.label!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            if (widget.label != null && widget.validator != null)
              const Text(
                '*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
              ),
          ],
        ),
        const SizedBox(height: 2),
        TextFormField(
          validator: widget.validator,
          maxLines: widget.maxLines,
          style: TextStyle(fontSize: 14, color: widget.disable ? const Color(0xff757575) : const Color(0xff0A0A0A)),
          controller: _controller,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: widget.disable,
            fillColor: const Color(0xfff5f5f5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            enabled: !widget.disable,
            border: widget.border
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1),
                  )
                : InputBorder.none,
            focusedBorder: widget.border
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: CustomColors.primary, width: 1.5),
                  )
                : InputBorder.none,
            disabledBorder: widget.border
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1),
                  )
                : InputBorder.none,
            enabledBorder: widget.border
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1),
                  )
                : InputBorder.none,
          ),
          inputFormatters: [CapitalizeFirstLetterFormatter()],
        ),
      ],
    );
  }
}
