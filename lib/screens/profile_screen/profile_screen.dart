import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/components/textformfield.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/log_services/user_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final UserServices userServices = UserServices();

  User? user;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserModel? userModel = await userServices.getUserData(user!.uid);
      if (userModel != null) {
        nameController.text = userModel.name;
        birthDateController.text = userModel.birthDate;
        emailController.text = userModel.email;
        phoneController.text = userModel.phoneNumber;
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> updateUser() async {
    if (user != null) {
      UserModel updatedUser = UserModel(
        name: nameController.text,
        birthDate: birthDateController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
      );
      await userServices.updateUser(user!.uid, updatedUser);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profil güncellendi!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profilim"),
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text("Ad Soyad",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Textformfield(
                  controller: nameController,
                  hintText: "Ad Soyad",
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                Text("Doğum Tarihi",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Textformfield(
                  controller: birthDateController,
                  hintText: "Doğum Tarihi",
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                Text("E-posta",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Textformfield(
                  controller: emailController,
                  hintText: "E-posta",
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                Text("Telefon Numarası",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Textformfield(
                  controller: phoneController,
                  hintText: "Telefon Numarası",
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Button(
                    onPressed: () {
                      updateUser();
                    },
                    title: "Güncelle",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
