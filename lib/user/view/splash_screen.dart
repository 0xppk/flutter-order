// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:order/common/const/colors.dart';
import 'package:order/common/layout/root_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RootLayout(
      bgColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "asset/img/logo/logo.png",
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
