import 'package:flutter/material.dart';

import 'login_screen_left_side.dart';
import 'login_screen_right_side.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              height: 640,
              width: 1080,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  if (MediaQuery.of(context).size.width > 900) ...[
                    const LoginPageLeftSide()
                  ],
                  LoginScreenRightSide(),
                ],
              )),
        ),
      ),
    );
  }
}
