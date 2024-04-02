import 'package:finch/config/constants.dart';
import 'package:finch/styles/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../styles/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/finch.jpg'),
            Text(
              appName,
              style: AppTheme.headerStyle(color: whiteColor),
            ),
            Text(
              'Better way to keep track of your loan',
              style: AppTheme.titleStyle(color: whiteColor),
            )
          ],
        ),
      ),
    );
  }

  void _navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      if (FirebaseAuth.instance.currentUser != null) {
        context.go('/loan_dashboard');
      } else {
        context.go('/register_screen');
      }
    });
  }
}
