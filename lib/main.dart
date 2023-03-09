import 'package:dasboard/ui/dashboard/dashboard_screen.dart';
import 'package:dasboard/ui/login/login_screen.dart';
import 'package:dasboard/ui/user_post/user_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'constants/app_colors.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathverse Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: AppColors.orangeAccent,
        primarySwatch: AppColors.orange,
      ),

      // TODO: check logged in or not using shared preferences
      // home: const LoginScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(dashboardNo: 1),
        '/user/posts': (context) => const UserPostScreen(userId: '1'),
      },
    );
  }
}
