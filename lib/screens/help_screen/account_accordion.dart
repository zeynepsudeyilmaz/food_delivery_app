import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class AccountAccordion extends StatelessWidget {
  const AccountAccordion({super.key});

  @override
  Widget build(BuildContext context) {
    return Accordion(
      maxOpenSections: 1,
      headerBackgroundColor: AppColors.primary,
      headerPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.light,
      sectionClosingHapticFeedback: SectionHapticFeedback.heavy,
      children: [
        AccordionSection(
          isOpen: true,
          header: Text('Hesabımı nasıl oluşturabilirim?'),
          content: Text(
            'Bir hesap oluşturmak için kayıt sayfasındaki  gerekli bilgileri doldurarak üyeliğinizi tamamlayın.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('Şifremi unuttum, nasıl sıfırlayabilirim?'),
          content: Text(
            'Şifrenizi unuttuysanız, "Giriş Yap" sayfasındaki "Şifremi Unuttum" seçeneğine tıklayın ve e-posta adresinizi girin. E-posta adresinize gönderilen bağlantı ile şifrenizi sıfırlayabilirsiniz.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('Hesap bilgilerimi nasıl güncelleyebilirim?'),
          content: Text(
            'Hesap bilgilerinizde değişiklik yapmak için hesabınıza giriş yaptıktan sonra sağ üstten "Profilim" bölümüne giderek güncellemeler yapabilirsiniz.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('E-posta adresimi nasıl değiştirebilirim?'),
          content: Text(
            'E-posta adresinizi değiştirmek için "Profilim" kısmında bulunan "Bilgilerimi Güncelle" seçeneğine tıklayarak yeni e-posta adresinizi tanımlayabilirsiniz.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('Hesabımı nasıl silebilirim?'),
          content: Text(
            'Hesabınızı kalıcı olarak silmek için "Ayarlar" kısmından "Hesabımı Sil" bölümüne gitmeniz gerekmektedir. Hesap silme işlemi geri alınamaz ve tüm verileriniz kalıcı olarak silinir.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
    );
  }
}
