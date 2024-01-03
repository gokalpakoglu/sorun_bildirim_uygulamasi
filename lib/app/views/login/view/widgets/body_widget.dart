// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.dart';
// import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.gr.dart';

// class BodyWidget extends StatefulWidget {
//   const BodyWidget({super.key});

//   @override
//   State<BodyWidget> createState() => _BodyWidgetState();
// }

// class _BodyWidgetState extends State<BodyWidget> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 10),
//           const Text('Email address'),
//           const SizedBox(height: 5),
//           TextFormField(
//             controller: emailController,
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Enter your email',
//             ),
//           ),
//           const SizedBox(height: 5),
//           const Text('Password'),
//           TextFormField(
//             controller: passwordController,
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Enter your password',
//             ),
//             obscureText: false,
//           ),
//           const SizedBox(height: 5),
//           GestureDetector(
//             onTap: () {},
//             child: const Text(
//               'Forgot password?',
//               style: TextStyle(
//                 color: Colors.deepPurple,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           BlocConsumer<AuthenticationBloc, AuthenticationState>(
//             listener: (context, state) {
//               if (state is AuthenticationSuccess) {
//                 AppRouter().push(const HomeRoute());
//               } else if (state is AuthenticationFailure) {
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       return const AlertDialog(
//                         content: Text('error'),
//                       );
//                     });
//               }
//             },
//             builder: (context, state) {
//               return SizedBox(
//                 height: 50,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     BlocProvider.of<AuthenticationBloc>(context).add(LoginUser(
//                         email: emailController.text.toString().trim(),
//                         password: passwordController.text.toString().trim()));
//                   },
//                   child: Text(
//                     state is AuthenticationLoading ? '.......' : 'Login',
//                     style: const TextStyle(
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text("Don't you have accounts yet? "),
//               GestureDetector(
//                 onTap: () {
//                   AppRouter().push(const RegisterRoute());
//                 },
//                 child: const Text(
//                   'Register',
//                   style: TextStyle(
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
