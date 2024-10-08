import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';

import '../../utils/app_colors.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool orderUpdates = true;
  bool promotionalOffers = false;
  bool recommendations = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bildirim Ayarları"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hangi bildirimleri almak istersiniz?",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              inactiveTrackColor: AppColors.secondary,
              inactiveThumbColor: Colors.white,
              title: Text(
                "Sipariş Güncellemeleri",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              value: orderUpdates,
              onChanged: (bool value) {
                setState(() {
                  orderUpdates = value;
                });
              },
            ),
            SwitchListTile(
              inactiveTrackColor: AppColors.secondary,
              inactiveThumbColor: Colors.white,
              title: Text(
                "Promosyon Teklifleri",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              value: promotionalOffers,
              onChanged: (bool value) {
                setState(() {
                  promotionalOffers = value;
                });
              },
            ),
            SwitchListTile(
              inactiveTrackColor: AppColors.secondary,
              inactiveThumbColor: Colors.white,
              title: Text(
                "Öneriler",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              value: recommendations,
              onChanged: (bool value) {
                setState(() {
                  recommendations = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: Button(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ayarlar kaydedildi!")),
                  );
                },
                title: "Ayarları Kaydet",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
