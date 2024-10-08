import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class ServicesAccordion extends StatelessWidget {
  const ServicesAccordion({super.key});

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
          header: Text('Hangi yemekleri sipariş verebilirim?'),
          content: Text(
            'Uygulamamızda birçok farklı kategoriden yemek seçenekleri bulunmaktadır. Ana yemekler, aperatifler, tatlılar ve içecekler gibi çeşitli seçenekleri inceleyebilirsiniz.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('Teslimat süresi ne kadar?'),
          content: Text(
            'Siparişinizin teslimat süresi, bulunduğunuz konuma ve yoğunluğumuza bağlı olarak genellikle 30-60 dakika arasında değişmektedir.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('Siparişimi nasıl iptal edebilirim?'),
          content: Text(
            'Siparişinizi, yemek teslimatından 10 dakika öncesine kadar iptal edebilirsiniz. İptal işlemi için uygulamadaki sipariş geçmişi bölümüne giderek ilgili siparişi seçmeniz yeterlidir.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('Ödeme yöntemleriniz nelerdir?'),
          content: Text(
            'Uygulamamızda kredi kartı, banka kartı, kapıda ödeme ve dijital cüzdan gibi farklı ödeme yöntemleri bulunmaktadır. Ödeme işlemini, siparişinizi onaylarken seçebilirsiniz.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text(
              'Yemeklerinizin sağlıklı ve taze olduğunu nasıl garanti ediyorsunuz?'),
          content: Text(
            'Yemeklerimiz, taze ve kaliteli malzemelerle hazırlanmakta olup, hijyen standartlarına uygun olarak pişirilmektedir. Müşteri memnuniyetini ön planda tutarak, her zaman en iyi hizmeti vermeye çalışıyoruz.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
    );
  }
}
