import 'package:events/core/extensions/validation.dart';
import 'package:events/core/utill/Firebasefunctions/firebase_Auth.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/moduls/signin/Signin.dart';
import 'package:flutter/material.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/core/widgets/Customformfield.dart';
import 'package:events/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final numcontroller = TextEditingController();
  final formkey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double h;
    final double w;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Register"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                      height: 180,
                      width: 180,
                      child: Image.asset(
                        Appassets.logoo,
                      )),
                  CustomTextField(
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Name can't be empty";
                      }
                    },
                    controller: namecontroller,
                    hintText: "Name",
                    prefixIcon: Icons.email_sharp,
                  ).Setpadding(12),
                  CustomTextField(
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email can't be empty";
                      }
                      if (!Validation.isEmailValid(value)) {
                        return "plz enter a Valid Email";
                      }
                      return null;
                    },
                    controller: emailcontroller,
                    hintText: "Email",
                    prefixIcon: Icons.email_sharp,
                  ).Setoptionalpadding(context, 0, 12, 12, 12),
                  CustomTextField(
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return "password";
                      }
                      if (!Validation.isPasswordValid(value)) {
                        return "plz enter a Valid password";
                      }
                      return null;
                    },
                    controller: passcontroller,
                    hintText: "Password",
                    prefixIcon: Icons.lock,
                    isPassword: true,
                  ).Setoptionalpadding(context, 0, 12, 12, 12),
                  CustomTextField(

                  validator: (String? value) {
                  if (value != passcontroller.text ) {
                  return "password not match";
                  }},
                    hintText: "Re Password",
                    prefixIcon: Icons.lock,
                    isPassword: true,
                  ).Setoptionalpadding(context, 0, 12, 12, 12),
                ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      EasyLoading.show(status: 'Creating Account...'); // Show loading indicator

                      firebase_auth.CreatAaccount(
                        emailcontroller.text,
                        passcontroller.text,
                      ).then((onValue) {
                        EasyLoading.dismiss(); // Hide loading when response is received

                        if (onValue) {
                          navigatorkey.currentState!.pushReplacementNamed("layout"); // Navigate if successful
                        } else {
                          EasyLoading.showError("Account creation failed"); // Show error
                        }
                      }).catchError((error) {
                        EasyLoading.dismiss(); // Hide loading on error
                        EasyLoading.showError("An error occurred"); // Display generic error
                        print("Firebase Error: $error"); // Debugging purpose
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorpallete.darkblue,
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                    ),
                  ),
                ).Setoptionalpadding(context, 8, 6, 12, 12),

                  Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Already Have Account ? ",
                            style:
                                Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Inter",
                                    ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment
                                .middle, // Makes the widget align better
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding:
                                    EdgeInsets.zero, // Removes default padding
                                minimumSize:
                                    Size(0, 0), // Ensures no extra height/width
                                tapTargetSize: MaterialTapTargetSize
                                    .shrinkWrap, // Shrinks tap area
                              ),
                              onPressed: () {
                                navigatorkey.currentState!
                                    .pushNamed("/sign_in");
                              },
                              child: Text(
                                " Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 2,
                                      decorationColor: colorpallete.darkblue,
                                      color: colorpallete.darkblue,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).Setoptionalpadding(context, 0, 150.00, 0, 0),
            ),
          ),
        ));
  }
}
