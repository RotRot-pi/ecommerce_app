import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class CardShppingAddressCheckout extends StatelessWidget {
  final String title;
  final String body;
  final bool isactive;
  const CardShppingAddressCheckout(
      {super.key,
      required this.title,
      required this.body,
      required this.isactive});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isactive ? AppColors.secondaryColor : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                color: isactive ? Colors.white : null,
                fontWeight: FontWeight.bold)),
        subtitle: Text(body,
            style: TextStyle(
                color: isactive ? Colors.white : null,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
