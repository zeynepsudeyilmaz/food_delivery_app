import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/curved_navbar.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import 'package:lottie/lottie.dart';

class CompleteOrder extends StatelessWidget {
  const CompleteOrder({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CurvedNavbar()),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Siparişiniz Onaylandı"),
      ),
      body: Center(
        child: Column(
          children: [
            Lottie.network(
                "https://lottie.host/9043a95f-bbad-4273-aab0-e9c1abd872b6/I4R7y5PJpd.json"),
            Text(
              "Siparişiniz başarıyla oluşturulmuştur.",
              style: AppTextStyles.headlineMedium,
            )
          ],
        ),
      ),
    );
  }
}
