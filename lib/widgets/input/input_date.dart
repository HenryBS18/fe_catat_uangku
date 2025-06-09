part of '../widgets.dart';

class InputDate extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final double fontSize;
  final bool border;
  final bool disable;
  final bool datetime;
  final bool iconOn;
  final bool isRange;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(String? value)? validator;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final String? hint;

  const InputDate({
    Key? key,
    required this.label,
    required this.controller,
    this.fontSize = 14,
    this.border = true,
    this.disable = false,
    this.datetime = false,
    this.iconOn = true,
    this.isRange = false,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.validator,
    this.backgroundColor,
    this.focusNode,
    this.hint,
  }) : super(key: key);

  @override
  _InputDateState createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  Future<void> _selectDate(BuildContext context) async {
    if (widget.isRange) {
      // Show Date Range Picker
      final DateTimeRange? pickedRange = await showDateRangePicker(
        context: context,
        firstDate: widget.firstDate ?? DateTime(1900),
        lastDate: widget.lastDate ?? DateTime(2100),
        saveText: 'Simpan',
        helpText: 'Rentang tanggal',
      );

      if (pickedRange != null) {
        setState(() {
          widget.controller.text = "${DateFormat('dd/MM/yyyy').format(pickedRange.start)} - ${DateFormat('dd/MM/yyyy').format(pickedRange.end)}";
        });
      }
    } else {
      // Show Single Date Picker
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: widget.firstDate ?? DateTime(1900),
        lastDate: widget.lastDate ?? DateTime(2100),
        helpText: 'Pilih tanggal',
      );

      if (pickedDate != null) {
        if (widget.datetime) {
          _selectDatetime(context, pickedDate);
        } else {
          setState(() {
            widget.controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
          });
        }
      }
    }
  }

  Future<void> _selectDatetime(BuildContext context, DateTime pickedDate) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Pilih waktu',
      hourLabelText: 'Pilih jam',
      minuteLabelText: 'Pilih menit',
    );

    if (pickedTime != null) {
      final DateTime fullDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      setState(() {
        widget.controller.text = DateFormat('dd/MM/yyyy HH:mm').format(fullDateTime);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialDate != null) {
      if (widget.datetime) {
        widget.controller.text = DateFormat('dd/MM/yyyy HH:mm').format(widget.initialDate!);
      } else {
        widget.controller.text = DateFormat('dd/MM/yyyy').format(widget.initialDate!);
      }
    }
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
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.bold,
              ),
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
          enabled: !widget.disable,
          readOnly: true,
          style: TextStyle(
            fontSize: widget.fontSize,
            color: widget.disable ? const Color(0xff757575) : const Color(0xff0A0A0A),
          ),
          controller: widget.controller,
          focusNode: widget.focusNode,
          textAlignVertical: TextAlignVertical.center,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            border: widget.border
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
            hintText: widget.hint ?? (widget.isRange ? '23/03/2023 - 30/03/2023' : (widget.datetime ? '23/03/2023 13:00' : '23/03/2023')),
            suffixIcon: widget.iconOn ? const Icon(Icons.calendar_today) : null,
            hintStyle: TextStyle(fontSize: widget.fontSize, color: Colors.grey),
            contentPadding: widget.border ? const EdgeInsets.only(left: 8) : null,
            filled: widget.disable || widget.backgroundColor != null,
            fillColor: widget.backgroundColor ?? const Color(0xfff5f5f5),
          ),
        ),
      ],
    );
  }
}
