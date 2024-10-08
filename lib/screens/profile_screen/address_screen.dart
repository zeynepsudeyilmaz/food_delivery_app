import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/screens/profile_screen/add_address.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../services/address_services/address_services.dart';
import '../../utils/app_colors.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddressServices addressService = AddressServices();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kayıtlı Adreslerim"),
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
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: addressService.getAddresses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text(
                      "Kayıtlı adresiniz bulunmamaktadır.",
                      style: AppTextStyles.displaySmall,
                    ));
                  }

                  final addresses = snapshot.data!;

                  return ListView.separated(
                    itemCount: addresses.length,
                    separatorBuilder: (context, index) => Divider(
                      color: AppColors.primary,
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                    itemBuilder: (context, index) {
                      var addressData = addresses[index];
                      var addressId = addressData['id'];
                      return ListTile(
                        leading: Icon(
                          Ionicons.home_outline,
                          color: AppColors.primary,
                          size: 35,
                        ),
                        title:
                            Text(addressData['addressName'] ?? 'Adres adı yok'),
                        subtitle:
                            Text(addressData['address'] ?? 'Adres bilgisi yok'),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.bgColor,
                                  title: Text(
                                    "Adresi Sil",
                                    style: AppTextStyles.headlineMedium,
                                  ),
                                  content: Text(
                                    "Bu adresi silmek istediğinize emin misiniz?",
                                    style: AppTextStyles.displaySmall,
                                  ),
                                  actions: [
                                    Button(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        title: "İptal"),
                                    Button(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40),
                                        onPressed: () async {
                                          await addressService
                                              .deleteAddress(addressId);
                                          Navigator.of(context).pop();
                                        },
                                        title: "Sil")
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            LineAwesomeIcons.trash_solid,
                            color: AppColors.primary,
                            size: 35,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Center(
              child: Button(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AddAddress()),
                  );
                },
                title: "Yeni Adres Ekle",
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
