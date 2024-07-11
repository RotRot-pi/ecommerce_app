import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:ecommercecourse/core/constants/spaces.dart';
import 'package:flutter/material.dart';

class TopCardCart extends StatelessWidget {
  final String message;
  const TopCardCart({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.addEdgeInsetsOnly(bottom: p4),
      margin: AppSpacing.addEdgeInsetsSymmetric(horizontal: m20),
      // height: 20,
      decoration: BoxDecoration(
        color: AppColors.thirdColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.primaryColor)),
    );
  }
}
