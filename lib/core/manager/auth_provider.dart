import'dart:io';

import 'package:events/core/utill/Firebasefunctions/firebase_Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier{

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  UserCredential? user;

  Future<void> createaccount()async {
    user = await firebase_auth.CreatAaccountfirebase(emailController.text,
        passwordController.text ,
        nameController.text);
  }

  Future<void> loginaccount()async {
    user = await firebase_auth.Login(emailController.text,
        passwordController.text ,
       );
  }


  Future<void> resetpassword(String email)async{
    await firebase_auth.resetPassword(emailController.text);
  }

}



// import 'package:events/core/utill/Firebasefunctions/firebase_Auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class AuthProvider extends ChangeNotifier {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController rePasswordController = TextEditingController();
//   UserCredential? user;
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   Future<void> createAccount(BuildContext context) async {
//     if (formKey.currentState!.validate()) {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return const AlertDialog(
//             backgroundColor: Colors.transparent,
//             title: Center(
//                 child: CircularProgressIndicator(
//                   color: AppColors.primaryColor,
//                 )),
//           );
//         },
//       );
//       try {
//         user = await firebase_auth.CreatAaccount(
//             email: emailController.text,
//             password: passwordController.text,
//             name: nameController.text);
//         Navigator.pop(context);
//
//         if (user?.user != null) {
//           final snackBar = SnackBar(
//             elevation: 0,
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.transparent,
//             content: AwesomeSnackbarContent(
//               title: 'Success Login',
//               message: "hi ${user?.user?.displayName ?? ""}",
//
//               /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//               contentType: ContentType.success,
//             ),
//           );
//
//           ScaffoldMessenger.of(context)
//             ..hideCurrentSnackBar()
//             ..showSnackBar(snackBar);
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             RoutesName.layout,
//                 (route) => false,
//           );
//         } else {
//           const snackBar = SnackBar(
//             elevation: 0,
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.transparent,
//             content: AwesomeSnackbarContent(
//               title: 'ops..',
//               message: "try again",
//
//               /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//               contentType: ContentType.failure,
//             ),
//           );
//
//           ScaffoldMessenger.of(context)
//             ..hideCurrentSnackBar()
//             ..showSnackBar(snackBar);
//         }
//       } catch (e) {
//         print(e);
//       }
//     }
//   }
//
//   Future<void> login(BuildContext context) async {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return const AlertDialog(
//           backgroundColor: Colors.transparent,
//           title: Center(
//             child: CircularProgressIndicator(
//               color: AppColors.primaryColor,
//             ),
//           ),
//         );
//       },
//     );
//     try {
//       user = await FirebaseAuthManager.login(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//       Navigator.pop(context);
//       if (user?.user != null) {
//         final snackBar = SnackBar(
//           elevation: 0,
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: Colors.transparent,
//           content: AwesomeSnackbarContent(
//             title: 'Success Login',
//             message: "hi ${user?.user?.displayName ?? ""}",
//
//             /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//             contentType: ContentType.success,
//           ),
//         );
//
//         ScaffoldMessenger.of(context)
//           ..hideCurrentSnackBar()
//           ..showSnackBar(snackBar);
//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           RoutesName.layout,
//               (route) => false,
//         );
//       } else {
//         const snackBar = SnackBar(
//           elevation: 0,
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: Colors.transparent,
//           content: AwesomeSnackbarContent(
//             title: 'ops..',
//             message: "invalid email or password",
//
//             /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//             contentType: ContentType.failure,
//           ),
//         );
//
//         ScaffoldMessenger.of(context)
//           ..hideCurrentSnackBar()
//           ..showSnackBar(snackBar);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> resetPassword(BuildContext context) async {
//     Loading.show(context);
//     await FirebaseAuthManager.resetPassword(email: emailController.text);
//     Loading.hide(context);
//     const snackBar = SnackBar(
//       elevation: 0,
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.transparent,
//       content: AwesomeSnackbarContent(
//         title: 'Success Send',
//         message: "Check youre email",
//
//         /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//         contentType: ContentType.success,
//       ),
//     );
//
//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(snackBar);
//   }
// }