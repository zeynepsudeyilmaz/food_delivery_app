import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/utils/app_colors.dart';

import '../../services/payment_services/card_services.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cardName = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CardService _cardService = CardService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kart Ekle"),
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
              CreditCardWidget(
                enableFloatingCard: true,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: AppColors.primary,
                chipColor: Theme.of(context).scaffoldBackgroundColor,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: true,
                onCreditCardWidgetChange: (CreditCardBrand) {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Kart Adı",
                    hintText: "Kartınızın adını girin",
                  ),
                  onChanged: (value) {
                    setState(() {
                      cardName = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kart adı boş olamaz';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              CreditCardForm(
                obscureCvv: true,
                obscureNumber: true,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                inputConfiguration: InputConfiguration(
                  cardNumberDecoration: InputDecoration(
                    labelText: "Kart Numarası",
                    hintText: "XXXX XXXX XXXX XXXX",
                  ),
                  expiryDateDecoration: InputDecoration(
                    labelText: "Son Kullanma Tarihi",
                    hintText: "XX/XX",
                  ),
                  cvvCodeDecoration: InputDecoration(
                    labelText: "CVV",
                    hintText: "XXX",
                  ),
                  cardHolderDecoration: InputDecoration(
                    labelText: "Kart Sahibi",
                    hintText: "Ad Soyad",
                  ),
                ),
                onCreditCardModelChange: onCreditCardModelChange,
                formKey: formKey,
              ),
              const SizedBox(height: 20),
              Center(
                child: Button(
                  onPressed: _saveCard,
                  title: "Kartı Kaydet",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
    });
  }

  Future<void> _saveCard() async {
    if (formKey.currentState!.validate()) {
      try {
        await _cardService.addCard(
          cardHolderName,
          cardNumber,
          expiryDate,
          cvvCode,
          cardName,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kart başarıyla kaydedildi!')),
        );
        Navigator.pop(context);
      } catch (e) {
        print("hata: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kart kaydedilirken bir hata oluştu.')),
        );
      }
    }
  }
}
