import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:tasktrack/pages/home_page/homepage.dart';

class AuthProvider extends ChangeNotifier {
  Future<void> splashScreenLoading(context) async {
    try {
      Timer(Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );
      });
    } catch (e) {
      dev.log({e}.toString());
    }
  }
}
