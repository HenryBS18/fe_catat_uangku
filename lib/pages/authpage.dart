part of 'pages.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();
  final registerEmail = TextEditingController();
  final registerPassword = TextEditingController();
  final registerName = TextEditingController();
  final UserRepository _userRepo = UserRepository();

  String? loginEmailError;
  String? loginPasswordError;
  String? registerEmailError;
  String? registerPasswordError;
  String? registerNameError;

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(Util.getSnackBar(context, message));
  }

  void handleLogin() async {
    final email = loginEmail.text.trim();
    final password = loginPassword.text.trim();

    setState(() {
      loginEmailError = email.isEmpty ? 'Email tidak boleh kosong' : null;
      loginPasswordError = password.isEmpty ? 'Password tidak boleh kosong' : null;
    });

    if (loginEmailError != null || loginPasswordError != null) return;

    try {
      final message = await _userRepo.login(email, password);

      if (message != null) {
        _showSnackbar(context, message);

        if (message.toLowerCase().contains('berhasil')) {
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        } else if (message.toLowerCase().contains('password')) {
          setState(() {
            loginPasswordError = message;
          });
        }
      } else {
        _showSnackbar(context, 'Terjadi kesalahan yang tidak diketahui.');
      }
    } catch (e) {
      _showSnackbar(context, 'Terjadi kesalahan: $e');
    }
  }

  void handleRegister() async {
    final email = registerEmail.text.trim();
    final password = registerPassword.text.trim();
    final name = registerName.text.trim();

    setState(() {
      registerEmailError = email.isEmpty ? 'Email wajib diisi' : null;
      registerPasswordError = password.isEmpty ? 'Password wajib diisi' : null;
      registerNameError = name.isEmpty ? 'Nama wajib diisi' : null;
    });

    if (registerEmailError != null || registerPasswordError != null || registerNameError != null) return;

    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$').hasMatch(email)) {
      setState(() => registerEmailError = 'Format email tidak valid');
      return;
    }

    if (password.length < 6) {
      setState(() => registerPasswordError = 'Password minimal 6 karakter');
      return;
    }

    final message = await _userRepo.register(email, password, name);
    _showSnackbar(context, message!);

    if (message == 'Register berhasil') {
      setState(() => isLogin = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xFF20C997), Color(0xFF1E5FF6)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Catat Uangku', style: TextStyle(color: Colors.teal, fontSize: 14)),
                    SizedBox(height: 12),
                    Text(
                      'Log in or Register to your\nAccount',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text('Enter your email and password',
                        style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () => setState(() => isLogin = true),
                                  style: TextButton.styleFrom(
                                    backgroundColor: isLogin
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[200],
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                  child: Text('Log In',
                                      style: TextStyle(
                                          color: isLogin ? Colors.white : Colors.black)),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () => setState(() => isLogin = false),
                                  style: TextButton.styleFrom(
                                    backgroundColor: !isLogin
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[200],
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                  child: Text('Sign Up',
                                      style: TextStyle(
                                          color: !isLogin ? Colors.white : Colors.black)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          if (isLogin) ...[
                            CustomTextForm(
                                labelText: 'Email',
                                iconData: Icons.email,
                                controller: loginEmail,
                                errorText: loginEmailError),
                            const SizedBox(height: 16),
                            CustomTextForm(
                                labelText: 'Password',
                                iconData: Icons.lock,
                                obscureText: true,
                                controller: loginPassword,
                                errorText: loginPasswordError),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Checkbox(value: false, onChanged: (_) {}),
                                const Text('Remember me'),
                                const Spacer(),
                                TextButton(
                                    onPressed: () {}, child: const Text('Forgot Password ?')),
                              ],
                            ),
                            const SizedBox(height: 8),
                            CustomElevatedButton(
                                buttonText: 'Log In', onPressed: handleLogin),
                          ] else ...[
                            CustomTextForm(
                                labelText: 'Name',
                                iconData: Icons.person,
                                controller: registerName,
                                errorText: registerNameError),
                            const SizedBox(height: 16),
                            CustomTextForm(
                                labelText: 'Email',
                                iconData: Icons.email,
                                controller: registerEmail,
                                errorText: registerEmailError),
                            const SizedBox(height: 16),
                            CustomTextForm(
                                labelText: 'Password',
                                iconData: Icons.lock,
                                obscureText: true,
                                controller: registerPassword,
                                errorText: registerPasswordError),
                            const SizedBox(height: 8),
                            CustomElevatedButton(
                                buttonText: 'Sign Up', onPressed: handleRegister),
                          ],
                          const SizedBox(height: 16),
                          Row(
                            children: const [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text("Or"),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'lib/assets/icons/logogoogle.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                label: const Text("Continue with Google"),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  side: BorderSide(color: Colors.black12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                  foregroundColor: Colors.black87,
                                  textStyle: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
