import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/app_colors.dart';

class ContactAccordion extends StatelessWidget {
  const ContactAccordion({super.key});

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
          isOpen: false,
          leftIcon: Icon(
            Ionicons.call_outline,
            color: Colors.white,
            size: 30,
          ),
          header: Text('Müşteri Hizmetleri'),
          content: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('WhatsApp'),
          leftIcon: Icon(
            Ionicons.logo_whatsapp,
            color: Colors.white,
            size: 30,
          ),
          content: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('Facebook'),
          leftIcon: Icon(
            Ionicons.logo_facebook,
            color: Colors.white,
            size: 30,
          ),
          content: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('Instagram'),
          leftIcon: Icon(
            Ionicons.logo_instagram,
            color: Colors.white,
            size: 30,
          ),
          content: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        AccordionSection(
          isOpen: false,
          header: Text('Web Site'),
          leftIcon: Icon(
            Ionicons.globe_outline,
            color: Colors.white,
            size: 30,
          ),
          content: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
    );
  }
}
