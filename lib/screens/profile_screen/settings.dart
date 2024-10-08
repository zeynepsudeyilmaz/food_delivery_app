import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/profile_screen/delete_account.dart';
import 'package:food_delivery_app/screens/profile_screen/notification_settings.dart';
import 'package:food_delivery_app/screens/profile_screen/password_settings.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Ionicons.notifications_outline,
                  size: 35,
                  color: AppColors.primary,
                ),
                title: Text("Bildirim Ayarları"),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationSettings()));
                  },
                  icon: Icon(
                    Ionicons.chevron_forward_outline,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Ionicons.key_outline,
                  size: 35,
                  color: AppColors.primary,
                ),
                title: Text("Şifre Ayarları"),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordSettings()));
                  },
                  icon: Icon(
                    Ionicons.chevron_forward_outline,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Ionicons.person_outline,
                  size: 35,
                  color: AppColors.primary,
                ),
                title: Text("Hesap Sil"),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeleteAccount()));
                  },
                  icon: Icon(
                    Ionicons.chevron_forward_outline,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
