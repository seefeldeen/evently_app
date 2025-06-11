import 'package:events/core/extensions/validation.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:events/core/manager/auth_provider.dart';
import 'package:events/core/widgets/Customtextshape.dart';
import 'package:flutter/material.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/widgets/Customformfield.dart';
import 'package:events/main.dart';
import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class Signup extends StatelessWidget {
   Signup({super.key});


  final formkey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider =  Provider.of<app_provider>(context);
    var Providerkind =  Provider.of<AuthProvider>(context);

     return  Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                centerTitle: true,
                  title: Customtextshape.Getbigtextchoose(
                      context.tr.register, context,
                      colorpallete.darkblue),
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
                                return context.tr.nameCantBeEmpty;
                              }
                              return null;
                            },
                            controller:Providerkind.nameController ,
                            hintText: context.tr.name,
                            prefixIcon: const Icon(Icons.person)
                        ).Setpadding(12),
                        CustomTextField(
                            validator: ( value) {
                              if (value == null || value.trim().isEmpty) {
                                return context.tr.emailCantBeEmpty;
                              }
                              if (!Validation.isEmailValid(value)) {
                                return context.tr.plzEnterAValidEmail;
                              }
                              return null;
                            },
                            controller: Providerkind.emailController,
                            hintText: context.tr.email,
                            prefixIcon: const Icon(Icons.email)
                        ).Setoptionalpadding(context, 0, 12, 12, 12),
                        CustomTextField(
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return context.tr.password;
                            }
                            if (!Validation.isPasswordValid(value)) {
                              return context.tr.plzEnterAValidPassword;
                            }
                            return null;
                          },
                          controller: Providerkind.passwordController,
                          hintText: context.tr.password,
                          prefixIcon: const Icon(Icons.lock),
                          isPassword: true,
                        ).Setoptionalpadding(context, 0, 12, 12, 12),
                        CustomTextField(
                          controller: Providerkind.rePasswordController,
                          validator: (String? value) {
                            if (value != Providerkind.rePasswordController.text ) {
                              return context.tr.passwordNotMatch;
                            }
                            return null;},
                          hintText: context.tr.rePassword,
                          prefixIcon: const Icon(Icons.lock),
                          isPassword: true,
                        ).Setoptionalpadding(context, 0, 12, 12, 12),
                        ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {

                              EasyLoading.show(status: context.tr.creatingAccount); // Show loading indicator

                              Providerkind.createaccount();

                            }
                            else {
                              EasyLoading.show(status: context.tr.anErrorOccurred); // Show loading indicator
                            }

                          },


                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorpallete.darkblue,
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Text(
                            context.tr.createAccount,
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
                                  text: context.tr.alreadyHaveAccount,
                                  style:
                                  Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.grey,
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
                                      const Size(0, 0), // Ensures no extra height/width
                                      tapTargetSize: MaterialTapTargetSize
                                          .shrinkWrap, // Shrinks tap area
                                    ),
                                    onPressed: () {
                                      navigatorKey.currentState!
                                          .pushNamed("/sign_in");
                                    },
                                    child: Text(" ${context.tr.login}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 0,
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
