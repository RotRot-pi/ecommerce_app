import 'package:ecommercecourse/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomItemsCartList extends StatelessWidget {
  final String name;
  final String price;
  final String count;
  final onAdd;
  final onRemove;
  final imageName;
  const CustomItemsCartList({
    super.key,
    required this.name,
    required this.price,
    required this.count,
    this.onAdd,
    this.onRemove,
    this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 2,
          child: Image.network(
            imageName,
            height: 90,
            fit: BoxFit.cover,
          )),
      Expanded(
          flex: 3,
          child: ListTile(
            title: Text(name, style: const TextStyle(fontSize: 15)),
            subtitle: Text(price,
                style: const TextStyle(
                    color: AppColors.primaryColor, fontSize: 17)),
          )),
      Expanded(
          child: Column(
        children: [
          SizedBox(
              height: 35,
              child: IconButton(onPressed: onAdd, icon: const Icon(Icons.add))),
          SizedBox(
              height: 30,
              child: Text(
                count,
                style: const TextStyle(fontFamily: "sans"),
              )),
          SizedBox(
              height: 25,
              child: IconButton(
                  onPressed: onRemove, icon: const Icon(Icons.remove)))
        ],
      ))
    ]);
  }
}
