import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:ecommercecourse/core/constants/spaces.dart';
import 'package:flutter/material.dart';

class CardDeliveryTypeCheckout extends StatelessWidget {
  final String imagename;
  final String title;
  final bool active;
  const CardDeliveryTypeCheckout(
      {super.key,
      required this.imagename,
      required this.title,
      required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h120,
      width: w120,
      decoration: BoxDecoration(
          color: active ? AppColors.secondaryColor : null,
          border: Border.all(color: AppColors.secondaryColor)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          imagename,
          width: w64,
          color: active ? Colors.white : null,
        ),
        Text(
          title,
          style: TextStyle(
              color: active ? Colors.white : AppColors.secondaryColor,
              fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
