import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/components/divider.dart';
import 'package:food_delivery_app/screens/profile_screen/address_screen.dart';
import 'package:food_delivery_app/screens/profile_screen/payments.dart';
import 'package:food_delivery_app/screens/log_screens.dart/login_screen.dart';
import 'package:food_delivery_app/screens/orders_screen/orders_screen.dart';
import 'package:food_delivery_app/screens/profile_screen/profile_screen.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import 'package:ionicons/ionicons.dart';

import 'settings.dart';
import '../../services/log_services/user_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfilePage> {
  final userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          Column(
            children: [
              GestureDetector(
                child: ListTile(
                  leading:
                      const Icon(Ionicons.person_outline, color: Colors.black),
                  title: Text("Profilim",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                },
              ),
              const MyDivider(color: Colors.black, thickness: 0.3),
              GestureDetector(
                child: ListTile(
                  leading:
                      const Icon(Ionicons.card_outline, color: Colors.black),
                  title: Text("Siparişlerim",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersScreen(
                        isFromNavbar: true,
                      ),
                    ),
                  );
                },
              ),
              const Divider(color: Colors.black, thickness: 0.3),
              GestureDetector(
                child: ListTile(
                  leading:
                      const Icon(Ionicons.book_outline, color: Colors.black),
                  title: Text("Kayıtlı Adreslerim",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddressScreen()),
                  );
                },
              ),
              const MyDivider(color: Colors.black, thickness: 0.3),
              GestureDetector(
                child: ListTile(
                  leading:
                      const Icon(Ionicons.wallet_outline, color: Colors.black),
                  title: Text("Ödeme Yöntemlerim",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Payments()),
                  );
                },
              ),
              const MyDivider(color: Colors.black, thickness: 0.3),
              GestureDetector(
                child: ListTile(
                  leading: const Icon(Ionicons.settings_outline,
                      color: Colors.black),
                  title: Text("Ayarlar",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()),
                  );
                },
              ),
              const MyDivider(color: Colors.black, thickness: 0.3),
              GestureDetector(
                child: ListTile(
                  leading:
                      const Icon(Ionicons.log_out_outline, color: Colors.black),
                  title: Text("Çıkış Yap",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black)),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Çıkış Yap"),
                        content: Text(
                          "Çıkış yapmak istediğinize emin misiniz?",
                          style: AppTextStyles.displaySmall,
                        ),
                        actions: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Button(
                                    backgroundColor: AppColors.secondary,
                                    foregroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    title: "İptal"),
                                const SizedBox(width: 20),
                                Button(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    onPressed: () {
                                      userServices.signOut();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LogIn()),
                                      );
                                    },
                                    title: "Çıkış yap"),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
