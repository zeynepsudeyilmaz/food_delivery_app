import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/services/log_services/user_services.dart';
import '../../components/textformfield.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    UserServices userServices = UserServices();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Şifre Sıfırlama'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "E-posta",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 8.0),
                Textformfield(
                  controller: emailController,
                  hintText: "E-postanızı giriniz",
                  obscureText: false,
                  validator: (data) {
                    if (data == null || data.isEmpty) {
                      return 'E-posta boş bırakılamaz';
                    }
                    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                    if (!regex.hasMatch(data)) {
                      return 'Lütfen geçerli bir e-posta adresi girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Button(
                  onPressed: () {
                    userServices.resetPassword(emailController.text.trim());
                  },
                  title: "Şifreyi Sıfırla",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
