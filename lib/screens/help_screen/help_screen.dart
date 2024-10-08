import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/help_screen/contact_us.dart';
import 'package:food_delivery_app/screens/help_screen/sss.dart';

import '../../utils/app_colors.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({
    super.key,
  });

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yardım ve SSS"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              ButtonsTabBar(
                duration: 0,
                radius: 20,
                height: 50,
                elevation: 4,
                backgroundColor: AppColors.primary,
                unselectedBackgroundColor: AppColors.color1,
                unselectedLabelStyle: TextStyle(
                  color: AppColors.color2,
                ),
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                labelSpacing: 8.0,
                tabs: const [
                  Tab(text: 'Sıkça Sorulan Sorular'),
                  Tab(text: 'Bizimle İletişime Geç'),
                ],
              ),
              const SizedBox(height: 16.0),
              const Expanded(
                child: TabBarView(
                  children: [
                    SSS(),
                    ContactAccordion(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
