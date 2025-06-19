part of 'pages.dart';

class SplashscreenPage extends StatefulWidget {
  const SplashscreenPage({Key? key}) : super(key: key);

  @override
  State<SplashscreenPage> createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  void checkAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    await Future.delayed(const Duration(seconds: 1));

    if (token == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login-page', (route) => false);
      return;
    }

    Navigator.pushNamedAndRemoveUntil(context, '/main-page', (route) => false);
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 171, 208, 255)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'lib/assets/icons/logo-catat-uangku.png',
                width: 280,
                height: 280,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
