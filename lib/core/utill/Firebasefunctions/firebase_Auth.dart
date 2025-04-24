import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:events/core/services/snackbarservice.dart';

class firebase_auth {

  static Future<UserCredential?> CreatAaccountfirebase(
      String emailAddress,
      String password,
      String name) async {
    EasyLoading.show();
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (credential.user !=null){
        snackbar.showCustomNotification(message: 'Account created successfully');
       await credential.user!.updateProfile(
          displayName: name
        );
        navigatorkey.currentState!.pushNamedAndRemoveUntil(
            route_names.layout,
                (route) => false);
      }
      return credential;

    }
  on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        snackbar.showCustomNotification(message: 'Weak password');
      } else if (e.code == 'email-already-in-use') {
        snackbar.showCustomNotification(message: 'Email is already in use');
      }
    }
    catch (e) {
      snackbar.showCustomNotification(message: 'An error occurred');
    } finally {
      EasyLoading.dismiss();
    }
    return null;
  }




  static Future<UserCredential?> Login(String emailAddress, String password) async {
    EasyLoading.show();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      snackbar.showCustomNotification(message: 'Login successfully');
      navigatorkey.currentState!.pushNamedAndRemoveUntil(
        route_names.layout,
            (route) => false,
      );      return credential;
    } on FirebaseAuthException catch (e) {
      snackbar.showCustomNotification(message: 'Login failed');

    } catch (e) {
      snackbar.showCustomNotification(message: 'An error occurred');

    } finally {
      EasyLoading.dismiss();
    }
    return null;
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      snackbar.showCustomNotification(message: 'Password reset email sent');
      return true;
    } catch (e) {
      snackbar.showCustomNotification(message: 'Error sending password reset email');
      return false;
    }
  }
}

