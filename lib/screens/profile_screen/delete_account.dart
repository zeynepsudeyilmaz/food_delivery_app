import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/services/log_services/user_services.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final userServices = UserServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hesabımı Sil"),
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
              Text(
                "Hesabınızı silmek üzeresiniz.",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                "Bu işlemi gerçekleştirdiğinizde, hesabınızla ilişkili tüm veriler kalıcı olarak silinecektir. Bu işlem geri alınamaz ve hesabınıza bir daha erişemezsiniz.",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 16),
              Text(
                "Lütfen silme işlemini onaylamadan önce aşağıdaki noktaları göz önünde bulundurun:",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(
                "- Hesabınızla ilgili tüm bilgiler (profil, geçmiş siparişler, ayarlar vb.) silinecektir.",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                "- Bu işlemden sonra hesabınızı tekrar açma şansınız yoktur.",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 20),
              Text(
                "Eğer hesabınızı gerçekten silmek istiyorsanız, lütfen 'Hesabı Sil' butonuna tıklayın.",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Button(
                    onPressed: () {
                      userServices
                          .deleteUser(FirebaseAuth.instance.currentUser!.uid);
                    },
                    title: "Hesabı Sil"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
