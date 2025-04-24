import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/manager/auth_provider.dart';
import 'package:events/core/models/Eventcategory.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/core/widgets/Customtextshape.dart';
import 'package:events/core/widgets/Cutomelevatedbutton.dart';
import 'package:events/main.dart';
import 'package:events/moduls/layout/Widgets/event_card.dart';
import 'package:events/moduls/layout/Widgets/hometapbar.dart';
import 'package:events/moduls/layout/home/home_tap.dart';
import 'package:events/moduls/layout/home/home_tap.dart';
import 'package:events/moduls/layout/home/home_tap.dart';
import 'package:events/moduls/layout/layoutprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../core/manager/app_provider.dart';

class HomeTap extends StatelessWidget {
  HomeTap({super.key});

  String username = FirebaseAuth.instance.currentUser?.displayName ?? "User";

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<app_provider>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // 👇 دي أهم سطر هنضيفه عشان نستخدم الفانكشن مرة واحدة بس بعد أول build
    final provider = Provider.of<LayoutProvider>(context, listen: false);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   provider.loadEventsByCategory("All"); // تحميل جميع البيانات عند أول فتح الصفحة
    // });
    return Consumer<LayoutProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: theme.appBarTheme.backgroundColor ??
                  colorpallete.parimary,
              toolbarHeight: 200,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              leadingWidth: double.infinity,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: .015.h),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Customtextshape.Getsmalltext(
                                "Welcome back", context),
                            Customtextshape.Getbigtext(username, context)
                                .Setoptionalpadding(
                                context, 4, 0, 0, 0, enablemediaquery: true),
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            appProvider.changeTheme();
                          },
                          child: SvgPicture.asset("assets/icons/Vector.svg")
                              .Setoptionalpadding(context, 0, 0, 8, 0),
                        ),
                        Cutomelevatedbutton(
                          onPressed: () {
                            appProvider.changeLang();
                          },
                          text: appProvider.lang == "en" ? 'ENG' : 'AR',
                          buttoncolor: colorpallete.parimary,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            color: theme.primaryColor),
                        Text(
                          "Cairo, Egypt",
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: .017.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: .02.h),

                    // ✅ TabBar with dynamic styling
                    DefaultTabController(
                      length: Eventcategory.categories.length,
                      child: TabBar(
                        tabAlignment : TabAlignment.start,
                        onTap: (index) async  {

                      provider.onTapSelected(index);

                      String categoryId = Eventcategory.categories[index].categorynam;

                      await provider.loadEventsByCategory(categoryId);
                      },
                        indicatorColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: isDark ? colorpallete.darkblue : Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: colorpallete.parimary,
                              width: 2),
                        ),
                        // أو indicatorColor: Colors.transparent
                        dividerHeight: 0,
                        isScrollable: true,
                        tabs: Eventcategory.categories
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          Eventcategory cat = entry.value;
                          return hometapbar(
                            text: cat.categorynam,
                            iconns: cat.categoryicon,
                            isselected: index == provider.tapSelectedIndex,
                          );
                        }).toList(),
                      ),
                    ),

                  ],
                ),
              ),
            ),
       body:
          ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: .015.w, vertical: .02.h),
            itemBuilder: (context, index) {
              final event = provider.filteredEvents[index];
              return EventCard(eventddatamodel: event);
            },
            separatorBuilder: (context, index) => SizedBox(height: .01.h),
            itemCount: provider.filteredEvents.length,
          )


          );

        }
    );
  }
}// int selectedTab = 0;





