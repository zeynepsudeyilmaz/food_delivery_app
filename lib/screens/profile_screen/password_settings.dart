import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/components/textformfield.dart';
import 'package:food_delivery_app/screens/log_screens.dart/reset_password_screen.dart';

import '../../services/log_services/user_services.dart';

class PasswordSettings extends StatefulWidget {
  const PasswordSettings({super.key});

  @override
  State<PasswordSettings> createState() => _PasswordSettingsState();
}

class _PasswordSettingsState extends State<PasswordSettings> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewController = TextEditingController();

  bool currentPasswordObscureText = true;
  bool newPasswordObscureText = true;
  bool confirmNewPasswordObscureText = true;

  @override
  void dispose() {
    currentPasswordController.dispose();
    confirmNewController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  void toggleCurrentPassword() {
    setState(() {
      currentPasswordObscureText = !currentPasswordObscureText;
    });
  }

  void toggleNewPassword() {
    setState(() {
      newPasswordObscureText = !newPasswordObscureText;
    });
  }

  void toggleConfirmNewPassword() {
    setState(() {
      confirmNewPasswordObscureText = !confirmNewPasswordObscureText;
    });
  }

  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Eski şifre boş bırakılamaz';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Yeni şifre boş bırakılamaz';
    }
    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    }
    return null;
  }

  String? validateConfirmNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Yeni şifre tekrar boş bırakılamaz';
    }
    if (value != newPasswordController.text) {
      return 'Şifreler eşleşmiyor';
    }
    return null;
  }

  Future<void> updatePassword() async {
    final userServices = UserServices();
    try {
      await userServices.updatePassword(newPasswordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Şifre başarıyla güncellendi!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Şifre Ayarları"),
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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Eski Şifre",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Textformfield(
                  controller: currentPasswordController,
                  obscureText: currentPasswordObscureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      currentPasswordObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: toggleCurrentPassword,
                  ),
                  validator: validateCurrentPassword,
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Text(
                      "Şifreni mi unuttun?",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPasswordScreen()));
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text("Yeni Şifre",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Textformfield(
                  controller: newPasswordController,
                  obscureText: newPasswordObscureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      newPasswordObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: toggleNewPassword,
                  ),
                  validator: validateNewPassword,
                ),
                const SizedBox(height: 16),
                Text("Yeni Şifre Tekrarı",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Textformfield(
                  controller: confirmNewController,
                  obscureText: confirmNewPasswordObscureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      confirmNewPasswordObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: toggleConfirmNewPassword,
                  ),
                  validator: validateConfirmNewPassword,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Button(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        updatePassword();
                      }
                    },
                    title: "Şifreyi Değiştir",
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
