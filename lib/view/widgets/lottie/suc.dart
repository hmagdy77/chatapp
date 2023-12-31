import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_sizes.dart';

class MyLottieSuc extends StatelessWidget {
  const MyLottieSuc({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/done1.json',
        width: 200,
        height: AppSizes.h2,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
