import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order/user/model/user_model.dart';
import 'package:order/user/provider/user_me_provider.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }
}
