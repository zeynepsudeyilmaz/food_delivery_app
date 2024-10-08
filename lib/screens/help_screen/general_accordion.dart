import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class GeneralAccordion extends StatelessWidget {
  const GeneralAccordion({super.key});

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
          header: Text('Ürünlerinizin garantisi var mı?'),
          content: Text(
            'Evet, tüm ürünlerimiz üretici garantisi altındadır. Garanti süresi ve şartları ürün detaylarında belirtilmiştir.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('Teslimat süresi ne kadar?'),
          content: Text(
            'Teslimat süresi, sipariş verdiğiniz ürünün stok durumuna ve bulunduğunuz konuma bağlı olarak 30-60 dakika arasında değişmektedir.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('İade politikanız nedir?'),
          content: Text(
            'Yemek siparişlerinde iade kabul edilmemektedir. Ancak, hatalı veya eksik teslimat durumunda müşteri hizmetlerimizle iletişime geçebilirsiniz.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('Yemekleriniz orijinal mi?'),
          content: Text(
            'Evet, uygulamamızda sunulan tüm yemekler, taze ve orijinal malzemelerle hazırlanmaktadır.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
    );
  }
}
