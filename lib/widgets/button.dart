part of 'widgets.dart';

class Button extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final double width;
  final double height;
  final VoidCallback onTap;
  final Icon? icon;
  final Color color;
  final BorderSide? border;
  final bool disabled;

  const Button({
    Key? key,
    required this.title,
    this.style,
    this.width = double.infinity,
    this.height = 48,
    this.onTap = defaultOnPressed,
    this.icon,
    this.color = CustomColors.primary,
    this.border,
    this.disabled = false,
  }) : super(key: key);

  static void defaultOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: disabled ? () {} : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled ? const Color(0xffe5e5e5) : color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: border ?? BorderSide(color: disabled ? const Color(0xffe5e5e5) : color),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            icon != null ? const SizedBox(width: 8) : const SizedBox(),
            Text(
              title,
              style: style ??
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: disabled ? const Color(0xff727272) : Colors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
