import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:flutter/material.dart';

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
    );
  }

  void _Btnnavigatorindex(int index) {
    setState(() {
      selectedindex = index; // ✅ Update selectedindex properly
    });
  }
}
