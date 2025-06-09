part of '../widgets.dart';

class Input extends StatefulWidget {
  final String label;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool border;
  final double fontSize;
  final String? hint;
  final bool disable;
  final String? initialValue;
  final TextInputType type;
  final String? Function(String? value)? validator;
  final bool alwaysUpperCase;
  final bool hideRequiredMark;
  final int? maxLength;
  final bool? counter;

  const Input({
    Key? key,
    required this.label,
    this.focusNode,
    this.controller,
    this.border = true,
    this.fontSize = 14,
    this.hint,
    this.disable = false,
    this.initialValue,
    this.type = TextInputType.text,
    this.validator,
    this.alwaysUpperCase = false,
    this.hideRequiredMark = false,
    this.maxLength,
    this.counter,
  }) : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  late TextEditingController _controller;

  TextInputFormatter? inputTypeCheck(TextInputType type) {
    switch (type) {
      case TextInputType.number:
        return FilteringTextInputFormatter.digitsOnly;
      case TextInputType.phone:
        return FilteringTextInputFormatter.digitsOnly;
      case TextInputType.emailAddress:
        return null;
      default:
        return CapitalizeFirstLetterFormatter();
    }
  }

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
            Text(
              widget.label,
              style: TextStyle(fontSize: widget.fontSize, fontWeight: FontWeight.bold),
            ),
            if (!widget.hideRequiredMark && widget.validator != null)
              const Text(
                '*',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
              ),
          ],
        ),
        const SizedBox(height: 2),
        TextFormField(
          validator: widget.validator,
          controller: _controller,
          focusNode: widget.focusNode,
          keyboardType: widget.type,
          maxLength: widget.maxLength,
          style: TextStyle(fontSize: widget.fontSize, color: widget.disable ? const Color(0xff757575) : const Color(0xff0A0A0A)),
          decoration: InputDecoration(
            counterText: widget.counter != null && widget.counter! ? null : '',
            filled: widget.disable,
            fillColor: const Color(0xfff5f5f5),
            contentPadding: const EdgeInsets.all(8),
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Colors.grey),
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
          enabled: !widget.disable,
          textCapitalization: widget.alwaysUpperCase ? TextCapitalization.characters : TextCapitalization.none,
          inputFormatters: [
            if (inputTypeCheck(widget.type) != null) inputTypeCheck(widget.type)!,
          ],
        ),
      ],
    );
  }
}
