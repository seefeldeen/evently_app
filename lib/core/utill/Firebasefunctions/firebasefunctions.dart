import 'package:events/core/services/snackbarservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class firebasefunctions{

  static Future<bool> CreatAaccount (String emailAddress , String password)

  async{
   EasyLoading.show();
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
snackbar.showCustomNotification( message: 'Account created successfuly');
return Future.value(true);
    } on FirebaseAuthException catch (e) {

      if (e.code == 'weak-password') {
        snackbar.showCustomNotification( message: 'weak password');
        print(e.message);
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        snackbar.showCustomNotification(message: 'email is already exist');

        print(e.message);
        return Future.value(false);

      }
      return Future.value(false);

    }
    catch (e) {
      print(e);
      return Future.value(false);

    }


  }static Future<bool> Login (String emailAddress , String password)

  async{
   EasyLoading.show();
   try {
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: emailAddress,
       password: password,
     );
snackbar.showCustomNotification( message: 'Login successfuly');
return Future.value(true);
    } on FirebaseAuthException catch (e) {

      if (e.code == 'weak-password') {
        snackbar.showCustomNotification( message: 'user not found');
        print(e.message);
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        snackbar.showCustomNotification(message: 'wrong password');

        print(e.message);
        return Future.value(false);

      }
      return Future.value(false);

    }
    catch (e) {
      print(e);
      return Future.value(false);

    }


  }



}