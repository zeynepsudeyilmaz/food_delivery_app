import 'package:flutter/material.dart';

void showDrawer(BuildContext context, Widget drawer) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation1, animation2) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, animation1, animation2, child) {
      final slideAnimation = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: animation1, curve: Curves.easeInOut),
      );

      return SlideTransition(
        position: slideAnimation,
        child: drawer,
      );
    },
  );
}
