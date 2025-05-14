
import 'package:events/core/routes/route_names.dart';
import 'package:events/core/utill/Firebasefunctions/firebase_Auth.dart';
import 'package:events/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../services/snackbarservice.dart';

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

  Future<void> signInWithGoogle() async {
    EasyLoading.show();
    user = await firebase_auth.signInWithGoogle();
    if (user?.user?.uid != null) {
      EasyLoading.dismiss();
      navigatorkey.currentState!.pushNamedAndRemoveUntil(
        route_names.layout,
            (route) => false,
      );
    } else {
      EasyLoading.dismiss();
      snackbar.showCustomNotification(
        message: 'An error occurred during Google sign-in',
        backgroundColor: Colors.red,
      );
      }
  }



}


