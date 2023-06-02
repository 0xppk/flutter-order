import 'package:flutter/material.dart';

class RootLayout extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final BottomNavigationBar? customBottomNavigationBar;
  final String? title;
  final Widget? floatingActionButton;

  const RootLayout({
    super.key,
    this.bgColor = Colors.white,
    this.customBottomNavigationBar,
    this.title,
    this.floatingActionButton,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      bottomNavigationBar: customBottomNavigationBar,
      backgroundColor: bgColor,
      body: child,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? customAppBar(BuildContext context) {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
  }
}
