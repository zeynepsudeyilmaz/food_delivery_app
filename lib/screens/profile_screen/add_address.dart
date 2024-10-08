import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/textformfield.dart';
import '../../services/address_services/address_services.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController addressNameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    final AddressServices _addressService = AddressServices();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adres Ekle"),
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
              Center(
                child: Icon(
                  Ionicons.home_outline,
                  color: AppColors.primary,
                  size: 80,
                ),
              ),
              const SizedBox(height: 20),
              Text("Adres Adı",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Textformfield(
                controller: addressNameController,
                obscureText: false,
              ),
              const SizedBox(height: 16),
              Text("Adres", style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Textformfield(
                controller: addressController,
                obscureText: false,
              ),
              const SizedBox(height: 60),
              Center(
                child: Button(
                    onPressed: () async {
                      String addressName = addressNameController.text.trim();
                      String address = addressController.text.trim();

                      if (addressName.isNotEmpty && address.isNotEmpty) {
                        await _addressService.addAddress(addressName, address);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Adres kaydedildi!")),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Lütfen tüm alanları doldurun")),
                        );
                      }
                    },
                    title: "Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
