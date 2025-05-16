part of 'widgets.dart';

class DotsIndicator extends StatelessWidget {
  final int dotsCount;
  final int position;
  final Color color;
  final Size size;
  final Color activeColor;
  final Size activeSize;

  const DotsIndicator({
    super.key,
    required this.dotsCount,
    required this.position,
    required this.color,
    required this.size,
    required this.activeColor,
    required this.activeSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        dotsCount,
        (index) => _buildDot(index),
      ),
    );
  }

  Widget _buildDot(int index) {
    bool isActive = index == position;
    return Container(
      width: isActive ? activeSize.width : size.width,
      height: isActive ? activeSize.height : size.height,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? activeColor : color,
      ),
    );
  }
}
