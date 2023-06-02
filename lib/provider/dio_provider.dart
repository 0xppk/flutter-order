import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order/common/dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(CustomInterceptor(storage: storage, ref: ref));

  return dio;
});

final secureStorageProvider =
    Provider<FlutterSecureStorage>((ref) => const FlutterSecureStorage());
