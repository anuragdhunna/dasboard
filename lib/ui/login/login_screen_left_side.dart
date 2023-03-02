import 'package:dasboard/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../constants/assets_path.dart';

class LoginPageLeftSide extends StatelessWidget {
  const LoginPageLeftSide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          color: AppColors.orange,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AssetsPath.appLogo))),
          ),
        ));
  }
}
