part of 'pages.dart';

class SplashscreenPage extends StatelessWidget {
  const SplashscreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Catat Uang',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
             Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    'lib/assets/icons/logo1.svg',
                    width: 64,
                    height: 64,
                  ),
                  SvgPicture.asset(
                    'lib/assets/icons/logo.svg',
                    width: 32,  
                    height: 32,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
