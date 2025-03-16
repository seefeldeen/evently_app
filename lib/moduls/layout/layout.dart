import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/widgets/Customtextshape.dart';
import 'package:events/core/widgets/Cutomelevatedbutton.dart';
import 'package:events/moduls/layout/Widgets/EventTypeTab.dart';
import 'package:events/moduls/layout/Widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class layout extends StatefulWidget {
  const layout({super.key});

  @override
  State<layout> createState() => _LayoutState();
}

class _LayoutState extends State<layout> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 5)),
        backgroundColor: colorpallete.darkblue,
        child: Icon(Icons.add, color: colorpallete.parimary),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        backgroundColor: colorpallete.darkblue,
        selectedItemColor: colorpallete.parimary,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedindex,
        unselectedItemColor: colorpallete.parimary,
        onTap: _Btnnavigatorindex, // ✅ Calls the fixed function
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
            activeIcon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: "Map",
            activeIcon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(), // Empty space for FAB
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: "Liked",
            activeIcon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "You",
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: .25.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: colorpallete.darkblue,
                borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(40),
                    bottomStart: Radius.circular(40))),
            padding: EdgeInsets.all(10),
            child: DefaultTabController(
              length: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: .025.h,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Customtextshape.Getsmalltext("Welcome back", context),
                          Customtextshape.Getbigtext("User", context)
                              .Setoptionalpadding(
                            context,
                            4,
                            0,
                            0,
                            0,
                            enablemediaquery: true,
                          ),
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset("assets/icons/Vector.svg")
                          .Setoptionalpadding(context, 0, 0, 8, 0),
                      Cutomelevatedbutton(
                        onPressed: () {},
                        text: 'ENG',
                        buttoncolor: colorpallete.parimary,
                      )
                    ],
                  ),
                  SizedBox(
                    height: .01.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: colorpallete.parimary,
                      ),
                      Text(
                        "cairo , egypt",
                        style: TextStyle(
                            color: colorpallete.parimary, fontSize: .017.h),
                      )
                    ],
                  ),
                  SizedBox(
                    height: .008.h,
                  ),
                  Expanded(
                      child: TabBar(
                          tabAlignment: TabAlignment.start,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          indicatorColor: Colors.transparent,
                          dividerColor: Colors.transparent,
                          isScrollable: true,
                          tabs: [
                        Eventtypetab(
                            text: "Sport",
                            iconns: Icons.bike_scooter,
                            isselected: true),
                        Eventtypetab(
                            text: "Sport",
                            iconns: Icons.bike_scooter,
                            isselected: false),
                        Eventtypetab(
                            text: "Sport",
                            iconns: Icons.bike_scooter,
                            isselected: false),
                        Eventtypetab(
                            text: "Sport",
                            iconns: Icons.bike_scooter,
                            isselected: false),
                      ]))
                ],
              ),
            ),
          ).Setoptionalpadding(context, 0, 8, 0, 0),
    Expanded(
      child: ListView.separated(itemBuilder: (context , index){

        return const event_card();
      },
      separatorBuilder: (context , index){
      
        return SizedBox(height: .02.h);
      },
      itemCount: 20),
    )      ],
      ),
    );
  }

  void _Btnnavigatorindex(int index) {
    setState(() {
      selectedindex = index; // ✅ Update selectedindex properly
    });
  }
}
