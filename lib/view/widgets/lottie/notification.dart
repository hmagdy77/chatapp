import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_sizes.dart';

class MyLottieNotification extends StatelessWidget {
  const MyLottieNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/notification-200px.json',
        width: AppSizes.w05,
        height: AppSizes.h05,
      ),
    );
  }
}
