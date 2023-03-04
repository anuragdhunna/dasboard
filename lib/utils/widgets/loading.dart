import 'package:dasboard/constants/assets_path.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: .8,
      child: Container(
        child: Center(
            child: Image.asset(
          AssetsPath.appLogo, //TODO: add proper
          height: 80,
        )),
      ),
    );
  }
}
