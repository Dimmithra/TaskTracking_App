import 'package:flutter/material.dart';
import 'package:tasktrack/providers/auth_provider.dart';
import 'package:tasktrack/utils/common_loader.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false)
          .splashScreenLoading(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  // CommonLoader(),
                  Image(
                    height: 250,
                    width: 250,
                    alignment: Alignment.center,
                    image: AssetImage("assets/images/splash_screen.png"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
