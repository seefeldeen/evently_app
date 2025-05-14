import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/validation.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:events/core/manager/auth_provider.dart';
import 'package:events/core/widgets/Customformfield.dart';
import 'package:events/core/widgets/Customtextshape.dart';
import 'package:events/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class forgetpass extends StatelessWidget {
  forgetpass({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<app_provider>(context);
    var apptheme = Theme.of(context);
    // بيشوف اللغة والثيم
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(
            builder: (BuildContext context, Providerkind, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              title: Customtextshape.Getbigtextchoose(
                  context.tr.forgetPassword, context,
                  colorpallete.darkblue),
              centerTitle: true,
            ),
            body: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(),
                  Image.asset(Appassets.change_setting),
                  const SizedBox(),
                  CustomTextField(
                    controller: Providerkind.emailController,
                    hintText: context.tr.email,
                    prefixIcon: const Icon(Icons.email),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.tr.emailCantBeEmpty;
                      }
                      if (!Validation.isEmailValid(value)) {
                        return context.tr.pleaseEnterAValidEmail;
                      }
                      return null;
                    },
                  ).Setverticalalpadding(context, .01),
                  // padding(context, 0, 12, .05, .05),
                  ElevatedButton(
                      onPressed: () {
                        Providerkind.resetpassword(
                            Providerkind.emailController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorpallete.darkblue,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        context.tr.resetPassword,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter"),
                      )).Setoptionalpadding(context, 0, 0, 12, 12)
                ],
              ).Setpadding(12),
            ),
          );
        }));
  }
}
