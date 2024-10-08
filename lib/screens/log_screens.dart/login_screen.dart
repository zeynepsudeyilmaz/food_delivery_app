import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/components/curved_navbar.dart';
import 'package:food_delivery_app/components/textformfield.dart';
import 'package:food_delivery_app/screens/log_screens.dart/reset_password_screen.dart';
import 'package:food_delivery_app/screens/log_screens.dart/signup_screen.dart';
import 'package:food_delivery_app/services/log_services/user_services.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final userServices = UserServices();
  bool obscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
          "Giriş Yap",
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CurvedNavbar()));
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 50, right: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "E-posta",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
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
                    const SizedBox(
                      height: 10.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Şifre",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Textformfield(
                      controller: passwordController,
                      obscureText: obscureText,
                      hintText: "Şifrenizi giriniz",
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
                    const SizedBox(height: 15),
                    Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPasswordScreen()));
                        },
                        child: Text(
                          "Şifreni mi unuttun?",
                          style: AppTextStyles.d1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Button(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 60),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                await userServices.signInWithEmailPassword(
                                    emailController.text,
                                    passwordController.text);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CurvedNavbar()),
                                );
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Hata'),
                                    content: Text(
                                      'E-posta veya şifre hatalı. Lütfen bilgilerinizi kontrol edin ve tekrar deneyin.',
                                      style: AppTextStyles.displaySmall,
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
                            }
                          },
                          title: "Giriş Yap",
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
                            "ya da şununla giriş yap",
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CurvedNavbar()),
                                );
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Hata'),
                                    content: const Text(
                                      'Giriş başarısız. Lütfen kontrol edin ve tekrar deneyin.',
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
                                  "Hesabın yok mu?",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  child:
                                      Text("Kayıt Ol", style: AppTextStyles.d1),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUp()));
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
            ],
          ),
        ),
      ),
    );
  }
}
