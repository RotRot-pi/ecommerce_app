import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:ecommercecourse/core/constants/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceAndCountItems extends StatelessWidget {
  final void Function()? onAdd;
  final void Function()? onRemove;
  final String price;
  final String count;
  const PriceAndCountItems(
      {super.key,
      required this.onAdd,
      required this.onRemove,
      required this.price,
      required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
            Container(
                alignment: Alignment.center,
                padding: AppSpacing.addEdgeInsetsOnly(bottom: h2),
                width: w56,
                decoration:
                    BoxDecoration(border: Border.all(color: AppColors.black)),
                child: Text(
                  count,
                  style: TextStyle(fontSize: 20.sp, height: 1.1.h),
                )),
            IconButton(onPressed: onRemove, icon: const Icon(Icons.remove)),
          ],
        ),
        const Spacer(),
        Text(
          "$price \$",
          style: TextStyle(
              color: AppColors.primaryColor, fontSize: 30.sp, height: 1.1.h),
        )
      ],
    );
  }
}
