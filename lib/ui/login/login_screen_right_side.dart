import 'dart:developer';

import 'package:dasboard/utils/helper_methods.dart';
import 'package:dasboard/utils/widgets/custom_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/assets_path.dart';
import '../../utils/widgetFunctions.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreenRightSide extends StatelessWidget {
  LoginScreenRightSide({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (MediaQuery.of(context).size.width < 900) ...[
                Center(
                  child: Container(
                    height: 100,
                    width: 300,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AssetsPath.appLogo))),
                  ),
                )
              ],
              addVerticalSpace(10),
              const Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              addVerticalSpace(12),
              CustomTextFormField(
                label: 'Email',
                hintText: 'Please enter your email',
                validationMessage: 'Invalid email address',
                icon: const Icon(Icons.email),
                controller: emailController,
              ),
              addVerticalSpace(12),
              CustomTextFormField(
                label: 'Password',
                hintText: 'Please enter your password',
                icon: const Icon(Icons.password),
                validationMessage: 'Please enter a password',
                controller: passwordController,
              ),
              addVerticalSpace(12),
              Align(
                alignment: Alignment.bottomRight,
                child: MaterialButton(
                    onPressed: () => forgotPassword(context),
                    child: const Text('Forgot Password?')),
              ),
              addVerticalSpace(12),
              MaterialButton(
                height: 50,
                elevation: 12,
                onPressed: () => submit(context),
                minWidth: double.infinity,
                color: AppColors.blueAccent,
                textColor: AppColors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: const Text('Login'),
              ),
              addVerticalSpace(12),
              const Center(child: Text('OR')),
              addVerticalSpace(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSocialIcon(AssetsPath.googleLogo),
                  addHorizontalSpace(12),
                  buildSocialIcon(AssetsPath.facebookLogo),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      HelperMethods().validateEmail(emailController.text);

      if (!EmailValidator.validate(emailController.text)) {
        log("=======vv========");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The E-mail Address must be a valid email address.',
              style: TextStyle(color: Colors.white)),
        ));
      }

      // API call
      // if credentials are not valid, show error message
      if (emailController.text != 'test@test.com' &&
          passwordController.text != 'test') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please enter va valid email address and password.',
              style: TextStyle(color: Colors.white)),
        ));
      }
      // Navigate to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  SizedBox buildSocialIcon(String iconPath) {
    return SizedBox(height: 30, width: 30, child: Image.asset(iconPath));
  }

  forgotPassword(BuildContext context) {}
}
