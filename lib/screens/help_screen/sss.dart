import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/help_screen/general_accordion.dart';
import 'package:food_delivery_app/screens/help_screen/services_accordion.dart';

import '../../utils/app_colors.dart';
import 'account_accordion.dart';

class SSS extends StatelessWidget {
  const SSS({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 30.0),
            tabs: const [
              Tab(text: 'Genel'),
              Tab(text: 'Hesap'),
              Tab(text: 'Hizmetler'),
            ],
          ),
          const SizedBox(height: 16.0),
          const Expanded(
            child: TabBarView(
              children: [
                GeneralAccordion(),
                AccountAccordion(),
                ServicesAccordion(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
