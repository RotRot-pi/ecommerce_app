import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class CardPaymentMethodCheckout extends StatelessWidget {
  final String title;
  final bool isActive;
  const CardPaymentMethodCheckout(
      {super.key, required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: isActive == true
              ? AppColors.secondaryColor
              : AppColors.fourthColor.withAlpha(150),
          borderRadius: BorderRadius.circular(20)),
      child: Text(title,
          style: TextStyle(
              color: isActive == true ? Colors.white : AppColors.secondaryColor,
              height: 1,
              fontWeight: FontWeight.bold)),
    );
  }
}
