import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_sizes.dart';

class MyLottieInternet extends StatelessWidget {
  const MyLottieInternet({super.key});
// assets/lottie/empty.json
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/internet.json',
        width: AppSizes.w3,
        height: AppSizes.h3,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
