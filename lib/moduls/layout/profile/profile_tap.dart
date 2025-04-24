import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:events/core/manager/auth_provider.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/core/utill/Firebasefunctions/firebase_Auth.dart';
import 'package:events/core/widgets/Customtextshape.dart';
import 'package:events/core/widgets/Cutomelevatedbutton.dart';
import 'package:events/main.dart';
import 'package:events/moduls/signin/Signin.dart';
import 'package:events/moduls/signin/Signin.dart';
import 'package:events/moduls/signin/Signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<app_provider>(context);
    var apptheme = Theme.of(context);
    var userEmail = FirebaseAuth.instance.currentUser?.email ?? "User";
    var username = FirebaseAuth.instance.currentUser?.displayName ?? "User";
    bool Isdark() => appProvider.currenttheme == ThemeMode.dark;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  Appassets.profile,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  top: 40,
                  right: .45.w,
                  child: Customtextshape.Getbigtext(
                    username ?? "User",
                    context,
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: .4.w,
                  child: Customtextshape.Getsmalltext(
                    userEmail,
                    context,
                  ),
                ),
              ],
            ),
            SizedBox(height: .02.h),
            Customtextshape.Getbigtextchoose(context.tr.lang,
                context,
                Isdark() ? colorpallete.parimary : Colors.black).
            Sethorizontalpadding(context, .05),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: colorpallete.darkTHEMR,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colorpallete.darkblue, width: 1.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              value: appProvider.lang,
              items: const [
                DropdownMenuItem(
                  value: "ar",
                  child: Text("العربية"),
                ),
                DropdownMenuItem(
                  value: "en",
                  child: Text("English"),
                ),
              ],
              onChanged: (value) {
          if (value != null && value != appProvider.lang) {
          appProvider.changeLang(); // غير اللغة فقط لو القيمة مختلفة
          }
          },
              hint: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: Colors.black),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: colorpallete.darkblue,
                  borderRadius: BorderRadius.circular(10),

                ),
                offset: const Offset(0, -5), // لو عايز تتحكم في اتجاه الظهور
              ),
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 8),
                height: 40,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ).Setresponsivepadding(context, .01, 0.05, .01, .01)
           ,

            Customtextshape.Getbigtextchoose(context.tr.theme,
                context,
                Isdark() ? colorpallete.parimary : Colors.black).
            Sethorizontalpadding(context, .05),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: colorpallete.darkTHEMR,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colorpallete.darkblue, width: 1.5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  value: appProvider.currenttheme == ThemeMode.dark ? "light" : "dark",
                  items: const [
                    DropdownMenuItem(
                      value: "light",
                      child: Text("Light"),
                    ),
                    DropdownMenuItem(
                      value: "dark",
                      child: Text("Dark"),
                    ),
                  ],
                  onChanged: (value) {
              if (value == "dark" && appProvider.currenttheme != ThemeMode.dark) {
              appProvider.changeTheme(); // روح للدارك
              } else if (value == "light" && appProvider.currenttheme != ThemeMode.light) {
              appProvider.changeTheme(); // روح لللايت
              }
              },
                  hint: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: Colors.black),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: colorpallete.darkblue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    offset: const Offset(0, -5), // لو عايز تتحكم في اتجاه الظهور
                  ),
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    height: 40,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ).Setresponsivepadding(context, .01, 0.05, .01, .01)
,


            ElevatedButton.icon(
              iconAlignment: IconAlignment.start,
              style: ElevatedButton.styleFrom(fixedSize:
                Size(.98.w, .06.h),
                backgroundColor: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                firebase_auth.logout();
                navigatorkey.currentState!.pushNamedAndRemoveUntil(
                route_names.Sign_in,
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout,color: Colors.white70,
              size: 30,), // الأيقونة
              label: Text(context.tr.logout,style:TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )), // النص
            ).Setresponsivepadding(
                enablemediaquery: true, context,
                .3, 0, .1, .1),
          ],
        ),
      ),
    );
  }
}
