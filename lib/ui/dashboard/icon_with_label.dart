import 'package:dasboard/constants/app_colors.dart';
import 'package:dasboard/utils/widgetFunctions.dart';
import 'package:flutter/material.dart';

class IconWithLabel extends StatelessWidget {
  const IconWithLabel({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: AppColors.orange),
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
