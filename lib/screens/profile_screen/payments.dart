import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/components/divider.dart';
import 'package:food_delivery_app/screens/profile_screen/add_card.dart';
import 'package:ionicons/ionicons.dart';
import '../../services/payment_services/card_services.dart';
import '../../utils/app_colors.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  final CardService _cardService = CardService();
  late Future<List<Map<String, dynamic>>> _cardsFuture;

  @override
  void initState() {
    super.initState();
    _cardsFuture = _cardService.getCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ödeme Yöntemleri"),
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
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _cardsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text("Henüz eklenmiş kart yok."));
                  }

                  return Column(
                    children: snapshot.data!.map((card) {
                      return Column(
                        children: [
                          ListTile(
                            minVerticalPadding: 30,
                            leading: Icon(
                              Ionicons.card_outline,
                              color: AppColors.primary,
                            ),
                            title: Text(
                              card['cardName'] ?? 'Kart Adı Yok',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            subtitle: Text(
                              card['expiryDate'],
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Ionicons.trash_outline,
                                color: AppColors.primary,
                              ),
                              onPressed: () async {
                                await _cardService.deleteCard(card['id']);
                                setState(() {
                                  _cardsFuture = _cardService.getCards();
                                });
                              },
                            ),
                          ),
                          MyDivider(
                            color: AppColors.primary,
                            thickness: 1,
                          ),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: Button(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddCard(),
                      ),
                    );
                  },
                  title: "Yeni Kart Ekle",
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
