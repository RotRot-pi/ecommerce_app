import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTitleHome extends StatelessWidget {
  final String title;
  const CustomTitleHome({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(
            fontSize: 20,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold));
  }
}
