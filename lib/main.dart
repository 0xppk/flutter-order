import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order/provider/observer_provider.dart';
import 'package:order/route/router.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [
        Logger(),
      ],
      child: const App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: "NotoSans",
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
