import 'package:flutter/material.dart';
import 'package:order/common/const/colors.dart';
import 'package:order/common/layout/root_layout.dart';
import 'package:order/order/view/order_screen.dart';
import 'package:order/product/view/product_screen.dart';
import 'package:order/restaurant/view/restaurant_screen.dart';
import 'package:order/user/view/profile_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({
    super.key,
  });

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int tabIndex = 0;
  late TabController controller;

  void tabListener() {
    setState(() {
      tabIndex = controller.index;
    });
  }

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RootLayout(
        title: "혜조 배달",
        customBottomNavigationBar: BottomNavigationBar(
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: BODY_TEXT_COLOR,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          // type: BottomNavigationBarType.fixed,
          // type: BottomNavigationBarType.shifting, // 선택된 탭을 강조
          onTap: (int index) {
            controller.animateTo(index);
          },
          currentIndex: tabIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "홈",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined),
              label: "음식",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              label: "주문",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: "프로필",
            ),
          ],
        ),
        child: TabBarView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            RestaurantScreen(),
            ProductScreen(),
            OrderScreen(),
            ProfileScreen(),
          ],
        ));
  }
}
