import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pantry_scanner/pages/Nav_Pages/Favorite_page.dart';
import 'package:pantry_scanner/pages/Nav_Pages/Home_page.dart';
import 'package:pantry_scanner/pages/Nav_Pages/ItemList_page.dart';
import 'package:pantry_scanner/pages/Nav_Pages/Profile_page.dart';
import 'package:pantry_scanner/pages/Nav_Pages/Scanner_page.dart';

class ButtomNavbarLayout extends StatefulWidget {
  const ButtomNavbarLayout({super.key});

  @override
  State<ButtomNavbarLayout> createState() => _HomePageState();
}

class _HomePageState extends State<ButtomNavbarLayout> {
  


  int _selectedIndex = 0;

  final List<String> _icons = [
      "assets/Icons/item_list.svg",
      "assets/Icons/home.svg",
      "assets/Icons/qr_code_scanner.svg",
      "assets/Icons/favorite.svg",
      "assets/Icons/profile.svg",
      
    ];

  static const List<Widget> _widgetOptions = <Widget>[
    ItemlistPage(),
    HomePage(),
    ScannerPage(),
    FavoritePage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),

      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9), // Set the background color of the bar
          borderRadius: BorderRadius.circular(34), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: const EdgeInsets.fromLTRB(8,1,8,8), // Add margin around the bar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_icons.length, (index) {
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == index ? const Color(0xFF3BD752) : Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  _icons[index],
                  color: _selectedIndex == index ? Colors.white : Colors.black,
                  width: 30,
                  height: 30,
                ),
              ),
            );
          }),
        ),
      ),
    );
       
  }
}