import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/profile_screen/profile_page.dart';
import 'package:food_delivery_app/screens/favorites_screen/favorites_screen.dart';
import 'package:food_delivery_app/screens/help_screen/help_screen.dart';
import 'package:food_delivery_app/screens/home_screen/home_screen.dart';
import 'package:food_delivery_app/screens/orders_screen/orders_screen.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:ionicons/ionicons.dart';

class CurvedNavbar extends StatefulWidget {
  const CurvedNavbar({super.key});

  @override
  State<CurvedNavbar> createState() => _CurvedNavbarState();
}

class _CurvedNavbarState extends State<CurvedNavbar> {
  int selectedIndex = 2;

  List<Widget> pages = [
    FavoritesScreen(),
    const OrdersScreen(
      isFromNavbar: false,
    ),
    const HomePage(),
    const HelpScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: AppColors.primary,
        index: selectedIndex,
        items: const [
          Icon(
            Ionicons.heart_outline,
            color: Colors.white,
          ),
          Icon(
            Ionicons.receipt_outline,
            color: Colors.white,
          ),
          Icon(
            Ionicons.home_outline,
            color: Colors.white,
          ),
          Icon(
            Ionicons.help_outline,
            color: Colors.white,
          ),
          Icon(
            Ionicons.person_outline,
            color: Colors.white,
          ),
        ],
        onTap: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
      ),
      body: pages[selectedIndex],
    );
  }
}
