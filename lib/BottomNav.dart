import 'package:flutter/material.dart';

import 'package:newsapp/pages/SearchCategory.dart';

import 'package:newsapp/pages/Profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:newsapp/pages/like.dart';
import 'package:newsapp/pages/ocr.dart';
import 'package:newsapp/pages/recommend.dart';

import 'pages/HomeScreen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const Screen3(),
    const ocr_text_recognize(),
    const SearchCategory(),
    const Profile(),
    const RecommendationScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: _screens[_selectedIndex],
        bottomNavigationBar: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            // color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: GNav(
                  // padding: EdgeInsets.all(),
                  onTabChange: (index) => _onItemTapped(index),
                  // backgroundColor: Colors.black,
                  activeColor: Colors.white,
                  color: Colors.purple,
                  tabBackgroundColor: Colors.purple,
                  padding: const EdgeInsets.all(16),
                  gap: 8,
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: "Home",
                    ),
                    GButton(
                      icon: Icons.favorite_border,
                      text: "Like",
                    ),
                    GButton(
                      icon: Icons.camera,
                      text: "OCR",
                    ),
                    GButton(
                      icon: Icons.search,
                      text: 'Search',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                    ),
                    GButton(
                      icon: Icons.receipt,
                      text: 'Recommendation',
                    ),
                  ]),
            ),
          ),
        ));
  }
}
