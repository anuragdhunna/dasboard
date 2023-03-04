import 'package:dasboard/constants/app_colors.dart';
import 'package:dasboard/utils/widgetFunctions.dart';
import 'package:flutter/material.dart';

class IconWithLabel extends StatelessWidget {
  const IconWithLabel({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            Icon(icon, color: AppColors.grey),
            addHorizontalSpace(3),
            Text(
              label,
              style:
                  TextStyle(color: AppColors.grey, fontWeight: FontWeight.w700),
            )
          ],
        ));
  }
}
