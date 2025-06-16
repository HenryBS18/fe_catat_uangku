part of 'widgets.dart';

class CustomDropdown<T> extends FormField<T> {
  CustomDropdown({
    Key? key,
    String? label,
    T? selectedItem,
    required List<T> items,
    required ValueChanged<T> onChanged,
    FormFieldValidator<T>? validator,
    bool border = true,
    bool isExpanded = true,
    bool isDense = false,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 8),
    double fontSize = 14,
    String? hint,
    bool isBold = false,
    bool disabled = false,
  }) : super(
          key: key,
          initialValue: selectedItem,
          validator: validator,
          builder: (FormFieldState<T> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (label != null)
                      Text(
                        label,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                      ),
                    if (label != null && validator != null)
                      const Text(
                        '*',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Container(
                  decoration: BoxDecoration(
                    border: border ? Border.all(color: state.hasError ? Colors.red.shade900 : const Color(0xffE0E0E0), width: 1) : null,
                    borderRadius: BorderRadius.circular(6),
                    color: disabled ? const Color(0xfff5f5f5) : null,
                  ),
                  padding: padding,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      isExpanded: isExpanded,
                      isDense: isDense,
                      value: items.contains(selectedItem) ? selectedItem : null,
                      hint: hint != null ? Text(hint, style: const TextStyle(fontSize: 14)) : null,
                      items: items.map((T item) {
                        return DropdownMenuItem<T>(
                          value: item,
                          child: Text(
                            item.toString(),
                            style: TextStyle(fontSize: fontSize, color: const Color(0xff0A0A0A), fontWeight: isBold ? FontWeight.bold : null),
                          ),
                        );
                      }).toList(),
                      onChanged: disabled
                          ? null
                          : (value) {
                              state.didChange(value);
                              onChanged(value as T);
                            },
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 200),
                      tween: Tween<double>(begin: -8, end: 0),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, value),
                          child: AnimatedOpacity(
                            opacity: state.hasError ? 1 : 0,
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 200),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Text(
                                state.errorText!,
                                style: TextStyle(color: Colors.red.shade900, fontSize: 12),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        );
}
