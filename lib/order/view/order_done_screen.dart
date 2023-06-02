import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:order/common/const/colors.dart';
import 'package:order/common/layout/root_layout.dart';

class OrderDoneScreen extends StatelessWidget {
  const OrderDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RootLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.thumb_up_alt_outlined,
              color: PRIMARY_COLOR,
              size: 50,
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              "결제가 완료되었습니다.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                context.go("/");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
              ),
              child: const Text("홈으로"),
            )
          ],
        ),
      ),
    );
  }
}
