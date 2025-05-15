// part of 'pages.dart';


// class LoginPage extends StatelessWidget {
//   final UserRepository _userRepo = UserRepository();

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   LoginPage({super.key});

//   void _showSnackbar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(Util.getSnackBar(context, message));
//   }

//   void handleLogin(BuildContext context) async {
//     try {
//       final String email = emailController.text;
//       final String password = passwordController.text;

//       await _userRepo.login(email, password);

//       // String message = await _userRepo.login(data);
//       // _showSnackbar(context, message);

//       Navigator.of(context).pushNamedAndRemoveUntil('/home', ((route) => false));
//     } catch (e) {
//       _showSnackbar(context, e.toString());
//     }
//   }
  

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
//             colors: [Color(0xFF20C997), Color(0xFF1E5FF6)],
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
//                     const Text('Catat Uangku', style: TextStyle(color: Colors.white70, fontSize: 14)),
//                     const SizedBox(height: 8),
//                     const Text('Log in to your\nAccount', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, height: 1.2)),
//                     const SizedBox(height: 8),
//                     const Text('Enter your email and password to log in', style: TextStyle(color: Colors.white70, fontSize: 14)),
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
//                         CustomTextForm(labelText: 'Email', iconData: Icons.email_sharp, controller: emailController),
//                         const SizedBox(height: 16),
//                         CustomTextForm(labelText: 'Password', iconData: Icons.lock_sharp, obscureText: true, controller: passwordController),
//                         const SizedBox(height: 24),
//                         CustomElevatedButton(buttonText: 'Login', onPressed: () => handleLogin(context)),
//                         const SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text("Don't have an account?"),
//                             TextButton(
//                               onPressed: () => Navigator.of(context).pushReplacementNamed('/register'),
//                               child: Text('Sign Up', style: TextStyle(color: Theme.of(context).colorScheme.tertiary, fontWeight: FontWeight.bold)),
//                             ),
//                           ],
//                         )
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
