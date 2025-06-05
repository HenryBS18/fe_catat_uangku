part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      final UserService userService = UserService();

      final isSuccess = await userService.register(User(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      ));

      if (isSuccess) {
        Navigator.pushNamedAndRemoveUntil(context, '/main-page', (route) => false);
        return;
      }
    } catch (e) {
      errorDialog(context, e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void unfocusAllFields() {
    nameFocus.unfocus();
    emailFocus.unfocus();
    passwordFocus.unfocus();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameFocus.dispose();
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
                    'Register your Account',
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
                            label: 'Name',
                            controller: nameController,
                            focusNode: nameFocus,
                            type: TextInputType.name,
                            validator: (value) => value!.isEmpty ? "Name tidak boleh kosong" : null,
                          ),
                          const SizedBox(height: 8),
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
                            label: 'Password',
                            focusNode: passwordFocus,
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) return "Password tidak boleh kosong";
                              if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$').hasMatch(value)) {
                                return "Minimal 8 karakter, 1 kapital, angka dan simbol";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          Button(title: 'Register', onTap: register),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have account?',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(context, '/login-page', (route) => false);
                                },
                                child: Text(
                                  'Login',
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
            if (isLoading) Loading(message: 'Registering account')
          ],
        ),
      ),
    );
  }
}
