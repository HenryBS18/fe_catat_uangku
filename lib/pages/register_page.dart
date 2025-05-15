//   part of 'pages.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({Key? key}) : super(key: key);

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final UserRepository _userRepo = UserRepository();
  
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();

//   void _showSnackbar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(Util.getSnackBar(context, message));
//   }

//   Future<void> handleRegister(BuildContext context) async {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();
//     final name = nameController.text.trim();

//     if (email.isEmpty || password.isEmpty || name.isEmpty) {
//       _showSnackbar(context, 'Email, password, dan nama wajib diisi!');
//       return;
//     }

//     if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
//       _showSnackbar(context, 'Format email tidak valid!');
//       return;
//     }

//     if (password.length < 6) {
//       _showSnackbar(context, 'Password harus memiliki minimal 6 karakter!');
//       return;
//     }

//     final message = await _userRepo.register(email, password, name);
//     _showSnackbar(context, message);

//     if (message == 'Register berhasil') {
//       Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
//     }
//   }

//   bool isSignUp = true; // Default halaman sign up

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.bottomLeft,
//             end: Alignment.topRight,
//             colors: [
//               Color(0xFF20C997),
//               Color(0xFF1E5FF6),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Catat Uangku',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       isSignUp ? 'Sign up to your Account' : 'Welcome Back!',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         height: 1.2,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       isSignUp
//                           ? 'Enter your email and password to log in'
//                           : 'Login to your account',
//                       style: const TextStyle(
//                         color: Colors.white70,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 24),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(24),
//                       topRight: Radius.circular(24),
//                     ),
//                   ),
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         // Tab Switch Buttons
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pushReplacementNamed('/login');
//                                   },
//                                   style: TextButton.styleFrom(
//                                     backgroundColor:
//                                         isSignUp ? Colors.transparent : Theme.of(context).primaryColor,
//                                     shape: const RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(12),
//                                         bottomLeft: Radius.circular(12),
//                                       ),
//                                     ),
//                                   ),
//                                   child: Text(
//                                     'Log In',
//                                     style: TextStyle(
//                                       color: isSignUp ? Colors.black54 : Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: TextButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       isSignUp = true;
//                                     });
//                                   },
//                                   style: TextButton.styleFrom(
//                                     backgroundColor:
//                                         isSignUp ? Theme.of(context).primaryColor : Colors.transparent,
//                                     shape: const RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(12),
//                                         bottomRight: Radius.circular(12),
//                                       ),
//                                     ),
//                                   ),
//                                   child: Text(
//                                     'Sign Up',
//                                     style: TextStyle(
//                                       color: isSignUp ? Colors.white : Colors.black54,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 24),

//                         // Form
//                         CustomTextForm(
//                           labelText: 'Name',
//                           iconData: Icons.person,
//                           controller: nameController,
//                         ),
//                         const SizedBox(height: 16),
//                         CustomTextForm(
//                           labelText: 'Email',
//                           iconData: Icons.email,
//                           controller: emailController,
//                         ),
//                         const SizedBox(height: 16),
//                         CustomTextForm(
//                           labelText: 'Password',
//                           iconData: Icons.lock,
//                           obscureText: true,
//                           controller: passwordController,
//                         ),
//                         const SizedBox(height: 24),

//                         CustomElevatedButton(
//                           buttonText: 'Register',
//                           onPressed: () => handleRegister(context),
//                         ),
//                         const SizedBox(height: 16),

//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text('Already have an account?'),
//                             TextButton(
//                               onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
//                               child: Text(
//                                 ' Login',
//                                 style: TextStyle(
//                                   color: Theme.of(context).colorScheme.tertiary,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),  
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

