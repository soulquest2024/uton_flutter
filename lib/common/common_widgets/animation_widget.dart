

import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class AnimationWidget extends StatelessWidget {
  const AnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/loading.json',
      width: 150,
      height: 150,
      fit: BoxFit.contain,
    );
  }
}