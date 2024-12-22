

import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class AnimationWidget extends StatelessWidget {
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