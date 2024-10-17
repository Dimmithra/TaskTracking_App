import 'package:flutter/material.dart';
import 'package:tasktrack/utils/common_colors.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: kLoaderColor,
    );
  }
}
