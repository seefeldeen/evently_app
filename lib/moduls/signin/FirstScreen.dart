import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/core/widgets/Customformfield.dart';
import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/validation.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/main.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset:true, // Allows UI to adjust when keyboard opens
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,// Prevents overflow by allowing scrolling
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: .05.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: .05.h),
                    Image.asset(
                      Appassets.logoo, // Replace with your logo path
                      height: 180,
                      width: 180,
                    ),
                     SizedBox(height: .02.h),

                    // Email TextField
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Email",
                      prefixIcon: Icons.email,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email can't be empty";
                        }
                        if (!Validation.isEmailValid(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                   SizedBox(height: .02.h),

                    // Password TextField
                    CustomTextField(
                      controller: _passController,
                      hintText: "Password",
                      prefixIcon: Icons.lock,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a password";
                        }
                        if (!Validation.isPasswordValid(value)) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                     SizedBox(height: .02.h),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          navigatorkey.currentState!.pushNamed(route_names.forgetpass);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: colorpallete.darkblue,
                          ),
                        ),
                      ),
                    ),

                     SizedBox(height: .02.h),

                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          EasyLoading.show(status: "Logging in...");

                          firebasefunctions.Login(
                            _emailController.text,
                            _passController.text,
                          ).then((onValue) {
                            EasyLoading.dismiss();

                            if (onValue) {
                              navigatorkey.currentState!.pushReplacementNamed(route_names.layout);
                            } else {
                              EasyLoading.showError("Login failed. Please try again.");
                            }
                          }).catchError((error) {
                            EasyLoading.dismiss();
                            EasyLoading.showError("An error occurred. Try again.");
                            print("Error: $error");
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorpallete.darkblue,
                        padding:  EdgeInsets.all(.01.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 0.025.h
                        ),
                      ),
                    ),
                     SizedBox(height: .04.h),

                    // Signup Navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            navigatorkey.currentState!.pushNamed(route_names.Sign_up);
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: colorpallete.darkblue,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // OR Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("OR"),
                        ),
                        Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Google Login Button
                    ElevatedButton(
                      onPressed: () {
                        navigatorkey.currentState!.pushReplacementNamed(route_names.layout);
                        // Google login function here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: colorpallete.darkblue),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Appassets.googlelogo, // Replace with your Google logo path
                            height: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Log in with Google",
                            style: TextStyle(color: colorpallete.darkblue),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
