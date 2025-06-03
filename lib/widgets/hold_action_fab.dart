part of '../pages/pages.dart';

class HoldActionFAB extends StatefulWidget {
  const HoldActionFAB({super.key});

  @override
  State<HoldActionFAB> createState() => _HoldActionFABState();
}

class _HoldActionFABState extends State<HoldActionFAB> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _fabKey = GlobalKey();
  final ValueNotifier<Offset?> _dragPosition = ValueNotifier(null);

  final List<_MenuOption> options = [
    _MenuOption(label: 'Manual', icon: Icons.edit),
    _MenuOption(label: 'Scan', icon: Icons.document_scanner),
    _MenuOption(label: 'Voice', icon: Icons.mic),
  ];

  int? _highlightedIndex;

  void _showOverlay() {
    final RenderBox renderBox =
        _fabKey.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Listener(
          onPointerMove: (event) {
            _dragPosition.value = event.position;
            _updateHighlight(event.position);
          },
          onPointerUp: (event) {
            _handleRelease(event.position);
          },
          child: Stack(
            children: [
              GestureDetector(onTap: _removeOverlay),
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),
              Positioned(
                left: position.dx + 28 - 100,
                top: position.dy + 28 - 240,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: ValueListenableBuilder<Offset?>(
                    valueListenable: _dragPosition,
                    builder: (context, dragOffset, _) {
                      return CustomPaint(
                        painter: _FanPainter(),
                        child: Stack(
                          children: List.generate(options.length, (i) {
                            Offset center;

                            const double visualOffsetY = 10;

                            if (i == 0) {
                              center = Offset(100, 40 + visualOffsetY);
                            } else if (i == 1) {
                              center = Offset(40, 100 + visualOffsetY);
                            } else {
                              center = Offset(160, 100 + visualOffsetY);
                            }

                            final isHighlighted = i == _highlightedIndex;

                            return Positioned(
                              left: center.dx - 28,
                              top: center.dy - (-10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    shape: const CircleBorder(),
                                    child: InkWell(
                                      onTap: () {
                                        print(
                                            'Tombol "${options[i].label}" disentuh');
                                        _selectOption(options[i]
                                            .label); // opsional: langsung jalankan aksinya
                                      },
                                      customBorder: const CircleBorder(),
                                      splashColor:
                                          Colors.green.withOpacity(0.3),
                                      highlightColor:
                                          Colors.green.withOpacity(0.1),
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        width: 56,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isHighlighted
                                              ? Colors.green
                                              : Colors.white,
                                          boxShadow: isHighlighted
                                              ? [
                                                  BoxShadow(
                                                    color: Colors.green
                                                        .withOpacity(0.4),
                                                    blurRadius: 10,
                                                    spreadRadius: 1,
                                                  )
                                                ]
                                              : [],
                                        ),
                                        child: Icon(options[i].icon,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    options[i].label,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _handleRelease(Offset globalPosition) {
    final RenderBox fabBox =
        _fabKey.currentContext!.findRenderObject() as RenderBox;
    final Offset fabOffset = fabBox.localToGlobal(Offset.zero);
    final Offset overlayCenter = fabOffset + const Offset(28, -180 + 100);

    for (int i = 0; i < options.length; i++) {
      Offset center;

      if (i == 0) {
        center = const Offset(100, 40); // Manual
      } else if (i == 1) {
        center = const Offset(40, 100); // Scan
      } else {
        center = const Offset(160, 100); // Voice
      }

      final optionCenter = overlayCenter + (center - const Offset(100, 100));

      if ((globalPosition - optionCenter).distance < 40) {
        _selectOption(options[i].label);
        return;
      }
    }

    _removeOverlay();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _dragPosition.value = null;
    setState(() {
      _highlightedIndex = null;
    });
  }

  void _updateHighlight(Offset globalPosition) {
    final RenderBox fabBox =
        _fabKey.currentContext!.findRenderObject() as RenderBox;
    final Offset fabOffset = fabBox.localToGlobal(Offset.zero);
    final Offset overlayCenter = fabOffset + const Offset(28, -180 + 100);

    for (int i = 0; i < options.length; i++) {
      Offset center;

      if (i == 0) {
        center = const Offset(100, 40); // Manual
      } else if (i == 1) {
        center = const Offset(40, 100); // Scan
      } else {
        center = const Offset(160, 100); // Voice
      }

      final optionCenter = overlayCenter + (center - const Offset(100, 100));
      if ((globalPosition - optionCenter).distance < 40) {
        setState(() => _highlightedIndex = i);
        return;
      }
    }

    setState(() => _highlightedIndex = null);
  }

  void _selectOption(String label) {
    _removeOverlay();
    if (label == 'Manual') {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const AddTransactionPageModal(),
      );
    } else if (label == 'Scan') {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const DummyScanModal(),
      );
    } else if (label == 'Voice') {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const VoiceModalPage(),
      );
    } else {
      debugPrint('Tombol "$label" aktif');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _fabKey,
      onLongPressStart: (_) => _showOverlay(),
      onLongPressMoveUpdate: (details) =>
          _dragPosition.value = details.globalPosition,
      onLongPressEnd: (details) => _handleRelease(details.globalPosition),
      child: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}

class _MenuOption {
  final String label;
  final IconData icon;
  const _MenuOption({required this.label, required this.icon});
}

class _FanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;
    canvas.drawCircle(size.center(Offset.zero), 100, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DummyScanModal extends StatelessWidget {
  const DummyScanModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Scaffold(
            appBar: AppBar(title: const Text("Scan (Dummy)")),
            body: const Center(child: Text("Ini halaman scan dummy")),
          ),
        );
      },
    );
  }
}
