import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/manager/auth_provider.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/core/utill/Firebasefunctions/firebase_Auth.dart';
import 'package:events/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:events/core/widgets/Customformfield.dart';
import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/validation.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:provider/provider.dart';

class Signin extends StatelessWidget {
   Signin({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<app_provider>(context);
    var Providerkind = Provider.of<AuthProvider>(context);
    var apptheme =Theme.of(context);
    // بيشوف اللغة والثيم

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: appProvider.currenttheme == ThemeMode.dark
                ? Colors.black
                : Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: .05.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: .05.h),
                        Image.asset(
                          Appassets.logoo,
                          height: 180,
                          width: 180,
                        ),
                        SizedBox(height: .02.h),

                        // Email
                        CustomTextField(
                          controller: Providerkind.emailController,
                          hintText: context.tr.email,
                          prefixIcon: const Icon(Icons.email)  ,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return context.tr.emailCantBeEmpty;
                            }
                            if (!Validation.isEmailValid(value)) {
                              return context.tr.pleaseEnterAValidEmail;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: .02.h),

                        // Password
                        CustomTextField(

                          controller: Providerkind.passwordController,
                          hintText: context.tr.password,
                          prefixIcon: const Icon(Icons.lock),
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return context.tr.pleaseEnterAPassword;
                            }
                            if (!Validation.isPasswordValid(value)) {
                              return context.tr.passwordMustBeAtLeast6Characters;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: .02.h),
                        // forgetpasswrod
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              navigatorKey.currentState!.pushNamed(route_names.forgetpass);
                            },
                            child: Text(
                              context.tr.forgotPassword,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: colorpallete.darkblue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: .02.h),

                        //login زرار
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              EasyLoading.show(status: context.tr.loggingIn);
                              firebase_auth.Login(
                                Providerkind.emailController.text,
                                Providerkind.passwordController.text,
                              ).then((onValue) {
                                EasyLoading.dismiss();
                                if (onValue != null) {
                                  // تخزين اسم المستخدم في الـ Provider بعد النجاح

                                  // بعد تخزين الاسم، انتقل إلى الشاشة التالية
                                  navigatorKey.currentState!.pushReplacementNamed(route_names.layout);
                                } else {
                                  EasyLoading.showError(context.tr.loginFailedPleaseTryAgain);
                                }
                              }).catchError((error) {
                                EasyLoading.dismiss();
                                EasyLoading.showError(context.tr.anErrorOccurredTryAgain);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorpallete.darkblue,
                            padding: EdgeInsets.all(.01.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            context.tr.login,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 0.025.h,
                            ),
                          ),
                        ),
                        SizedBox(height: .04.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(context.tr.dontHaveAnAccount,
                            style: Theme.of(context).textTheme.bodyMedium,),
                            TextButton(
                              onPressed: () {
                                navigatorKey.currentState!.pushNamed(route_names.Sign_up);
                              },
                              child: Text(
                                context.tr.createAccount,
                                style: const TextStyle(
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

                        Row(
                          children: [
                            const Expanded(child: Divider(color: Colors.grey)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(context.tr.or,
                                style: const TextStyle(
                                  color: colorpallete.darkblue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Expanded(child: Divider(color: Colors.grey)),
                          ],
                        ),

                        const SizedBox(height: 16),

                        ElevatedButton(
                          onPressed: () {
                            Providerkind.signInWithGoogle();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: colorpallete.darkblue),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(Appassets.googlelogo, height: 25),
                              const SizedBox(width: 10),
                              Text(
                                context.tr.logInWithGoogle,
                                style: const TextStyle(color: colorpallete.darkblue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Optional: أزرار لتغيير اللغة والثيم
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                appProvider.changeLang();
                              },
                              icon: const Icon(Icons.language),
                            ),
                            IconButton(
                              onPressed: () {
                                appProvider.changeTheme();
                              },
                              icon: const Icon(Icons.brightness_6),
                            ),
                          ],
                        )
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
