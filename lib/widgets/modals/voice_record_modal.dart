part of '../widgets.dart';

class VoiceModalPage extends StatefulWidget {
  const VoiceModalPage({super.key});

  @override
  State<VoiceModalPage> createState() => _VoiceModalPageState();
}

class _VoiceModalPageState extends State<VoiceModalPage> {
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          setState(() => _isListening = false);
        }
      },
      onError: (error) => debugPrint("Speech error: $error"),
    );
  }

  void _startListening() {
    _lastWords = '';
    _speech.listen(
      onResult: (result) => setState(() => _lastWords = result.recognizedWords),
      localeId: 'id_ID',
      partialResults: true,
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
    );
    setState(() => _isListening = true);
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _handleSubmitVoice() async {
    if (_lastWords.isEmpty) return;

    try {
      final noteData = await NoteService().voiceToNote(_lastWords);

      if (!mounted) return;
      Navigator.pop(context);
      await Future.delayed(const Duration(milliseconds: 100));

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => AddNotePageModal(initialData: noteData),
      );
    } catch (e) {
      CustomSnackbar.showError(context, 'Gagal memproses suara: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Scaffold(
            backgroundColor: const Color(0xFFF3F4F6),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFF0F55C3),
              centerTitle: true,
              title: const Text(
                'Catat via suara',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Panduan Pemakaian:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                              "• \"Hari ini saya membeli makan harga tiga puluh lima ribu di warung\""),
                          Text(
                              "• \"Hari ini saya mendapatkan gaji lima juta rupiah\""),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: height * 0.5,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, -4))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        height: 100,
                        child: Center(
                          child: Text(
                            _lastWords.isEmpty ? "..." : _lastWords,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: GestureDetector(
                          onLongPress: _startListening,
                          onLongPressUp: _stopListening,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: _isListening ? Colors.red : Colors.green,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.mic,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _isListening
                            ? "Sedang merekam... Lepas untuk berhenti"
                            : "Tekan & tahan untuk mulai bicara",
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: ElevatedButton.icon(
                          onPressed:
                              _lastWords.isEmpty ? null : _handleSubmitVoice,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text("Selanjutnya"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
