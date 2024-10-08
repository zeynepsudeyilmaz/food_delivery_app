import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/textformfield.dart';
import 'package:food_delivery_app/screens/log_screens.dart/login_screen.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/button.dart';
import '../../models/user_model.dart';
import '../../services/log_services/user_services.dart';
import '../../utils/app_colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final userServices = UserServices();
  bool obscureText = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();

  // Şifre görünürlüğü
  void togglePassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kayıt Ol",
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LogIn()));
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 50, right: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Adınız Soyadınız",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Textformfield(
                      hintText: "Ad Soyad",
                      controller: nameController,
                      obscureText: false,
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return 'Ad boş bırakılamaz';
                        }
                        final regex = RegExp(r'^[a-zA-ZÇĞİıÖŞÜçğıöşü ]+$');
                        if (!regex.hasMatch(data)) {
                          return 'Lütfen geçerli bir ad girin';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Şifreniz",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Textformfield(
                      hintText: "Şifre",
                      controller: passwordController,
                      obscureText: obscureText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: togglePassword,
                      ),
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return 'Şifre boş bırakılamaz';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("E-postanız",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Textformfield(
                      hintText: "example@example.com",
                      controller: emailController,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Telefon Numaranız",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Textformfield(
                      hintText: "05555555555",
                      controller: phoneController,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return 'Telefon numarası boş bırakılamaz';
                        }
                        final regex = RegExp(r'^05\d{9}$');
                        if (!regex.hasMatch(data)) {
                          return 'Lütfen geçerli bir telefon numarası girin';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Doğum Tarihiniz",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Textformfield(
                      controller: birthdayController,
                      obscureText: false,
                      keyboardType: TextInputType.datetime,
                      hintText: "GG-AA-YYYY",
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return 'Doğum tarihi boş bırakılamaz';
                        }
                        final regex = RegExp(
                            r'^\d{2}-\d{2}-\d{4}$'); // DD-MM-YYYY formatı
                        if (!regex.hasMatch(data)) {
                          return 'Lütfen geçerli bir tarih formatı girin (DD-MM-YYYY)';
                        }
                        try {
                          final parts = data.split('-');
                          final day = int.parse(parts[0]);
                          final month = int.parse(parts[1]);
                          final year = int.parse(parts[2]);

                          final date = DateTime(year, month, day);
                          if (date.year != year ||
                              date.month != month ||
                              date.day != day) {
                            return 'Lütfen geçerli bir tarih girin';
                          }
                          if (date.isAfter(DateTime.now())) {
                            return 'Tarih gelecekte olamaz';
                          }
                        } catch (e) {
                          return 'Lütfen geçerli bir tarih girin';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Button(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 60),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          UserModel newUser = UserModel(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            phoneNumber: phoneController.text.trim(),
                            birthDate: birthdayController.text.trim(),
                          );

                          await userServices.registerWithEmailPassword(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            newUser,
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogIn()),
                          );
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Hata'),
                              content: Text(e.toString()),
                              actions: <Widget>[
                                Button(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  title: 'Tamam',
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    title: "Kayıt Ol",
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "ya da şununla kayıt ol",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    IconButton(
                      icon: Icon(
                        Ionicons.logo_google,
                        color: AppColors.primary,
                        size: 50,
                      ),
                      onPressed: () async {
                        try {
                          await userServices.signInWithGoogle();
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            final userDoc = FirebaseFirestore.instance
                                .collection("users")
                                .doc(user.uid);
                            final userSnapshot = await userDoc.get();
                            if (!userSnapshot.exists) {
                              await userDoc.set({
                                "uid": user.uid,
                                "email": user.email,
                                "name": user.displayName ?? "Bilinmiyor",
                                "phoneNumber": user.phoneNumber ?? "Bilinmiyor",
                                "birthDate": "Bilinmiyor",
                                "createdDate": FieldValue.serverTimestamp(),
                              });
                            }
                          }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogIn()),
                          );
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Hata'),
                              content: const Text(
                                'Kayıt başarısız. Lütfen kontrol edin ve tekrar deneyin.',
                              ),
                              actions: <Widget>[
                                Button(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  title: 'Tamam',
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Zaten hesabın var mı?",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            child: Text(
                              "Giriş Yap",
                              style: AppTextStyles.d1,
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LogIn()));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
