part of 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      final UserService userService = UserService();

      final bool isSuccess = await userService.login(User(email: emailController.text, password: passwordController.text));

      if (isSuccess) {
        Navigator.pushNamedAndRemoveUntil(context, '/main-page', (route) => false);
        return;
      }
    } catch (e) {
      errorDialog(context, e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void unfocusAllFields() {
    emailFocus.unfocus();
    passwordFocus.unfocus();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocusAllFields,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xFF20C997), Color(0xFF1E5FF6)],
                ),
              ),
              padding: EdgeInsets.only(left: 24, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Catat Uangku',
                    style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    'Log in to your Account',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Input(
                            label: 'Email',
                            controller: emailController,
                            focusNode: emailFocus,
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) return "Email tidak boleh kosong";
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return "Email tidak valid";
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          InputPassword(
                            controller: passwordController,
                            focusNode: passwordFocus,
                            validator: (value) => value!.isEmpty ? "Password tidak boleh kosong" : null,
                          ),
                          const SizedBox(height: 24),
                          Button(title: 'Login', onTap: login),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have account?",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(context, '/register-page', (route) => false);
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(color: CustomColors.primary, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (isLoading) Loading(message: 'Verifying account')
          ],
        ),
      ),
    );
  }
}
