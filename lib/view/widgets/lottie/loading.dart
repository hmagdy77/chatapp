import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_sizes.dart';

class MyLottieLoading extends StatelessWidget {
  const MyLottieLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/loading.json',
        width: 200,
        height: AppSizes.h1,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
