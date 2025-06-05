part of '../widgets.dart';

class ScanModal extends StatefulWidget {
  const ScanModal({super.key});

  @override
  State<ScanModal> createState() => _ScanModalState();
}

class _ScanModalState extends State<ScanModal> {
  List<CameraDescription> _cameras = [];
  CameraController? _controller;
  File? _imageFile;
  bool _isCameraReady = false;
  bool _isFlashOn = false;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();

    // Ambil hanya kamera belakang
    final backCamera = _cameras.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.back,
      orElse: () => throw Exception("Kamera belakang tidak tersedia"),
    );

    _selectedCameraIndex = _cameras.indexOf(backCamera);
    await _startCamera(_selectedCameraIndex);
  }

  Future<void> _startCamera(int cameraIndex) async {
    _controller?.dispose();
    _controller = CameraController(_cameras[cameraIndex], ResolutionPreset.low,
        enableAudio: false);

    try {
      await _controller!.initialize();
      setState(() {
        _isCameraReady = true;
        _selectedCameraIndex = cameraIndex;
        _isFlashOn = false;
      });
    } catch (e) {
      debugPrint("Camera init error: $e");
    }
  }

  Future<void> _toggleFlash() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    _isFlashOn = !_isFlashOn;
    await _controller!
        .setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
    setState(() {});
  }

  Future<void> _captureImage() async {
    if (!_controller!.value.isInitialized) return;
    final XFile file = await _controller!.takePicture();
    setState(() => _imageFile = File(file.path));
  }

  Future<void> _pickFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, __) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Scan Bukti Transaksi"),
              centerTitle: true,
              actions: _imageFile == null && _isCameraReady
                  ? [
                      IconButton(
                        icon: Icon(
                          _isFlashOn ? Icons.flash_on : Icons.flash_off,
                        ),
                        onPressed: _toggleFlash,
                      ),
                    ]
                  : null,
            ),
            body: Column(
              children: [
                // Kamera atau preview
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: _imageFile != null
                        ? Image.file(_imageFile!, fit: BoxFit.cover)
                        : _isCameraReady
                            ? CameraPreview(_controller!)
                            : const Center(child: CircularProgressIndicator()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _imageFile == null
                      ? Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.camera_alt),
                                label: const Text("Capture"),
                                onPressed:
                                    _isCameraReady ? _captureImage : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.photo),
                                label: const Text("Gallery"),
                                onPressed: _pickFromGallery,
                              ),
                            ),
                          ],
                        )
                      : ElevatedButton.icon(
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text("Selanjutnya"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: () {
                            Navigator.pop(context, _imageFile);
                          },
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
