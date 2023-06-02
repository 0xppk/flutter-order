import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    print(
        "[업데이트] provider: $provider / 기존값: $previousValue / 변경된 값: $newValue");
  }

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    print("[추가] provider: $provider / value: $value");
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    print("[삭제] provider: $provider / container: $container");
  }
}
