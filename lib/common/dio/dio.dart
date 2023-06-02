// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:order/common/const/data.dart';
import 'package:order/user/provider/auth_provider.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInterceptor({
    required this.storage,
    required this.ref,
  });

  // 1) onRequest
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers["accessToken"] == "true") {
      options.headers.remove("accessToken");

      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      options.headers.addAll({"Authorization": "Bearer $token"});
    }

    print("[REQ] [${options.method} ${options.uri}]");
    return super.onRequest(options, handler);
  }

  // 2) onResponse
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "[REQ] [${response.requestOptions.method} ${response.requestOptions.uri}]");

    return super.onResponse(response, handler);
  }

  // 3) onError
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print("[ERR] [${err.requestOptions.method} ${err.requestOptions.uri}]");

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refreshToken이 없으면 바로 에러 확정
    if (refreshToken == null) {
      return handler.reject(err);
    }

    // 에러코드가 401이었고(토큰 만료), 에러를 보낸 페이지가 /auth/token 이었다면
    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == "/auth/token";

    // refreshToken에는 이상이 없고 accessToken은 만료된 상황
    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final res = await dio.post(
          "http://$ip/auth/token",
          options: Options(
            headers: {"Authorization": "Bearer $refreshToken"},
          ),
        );
        final accessToken = res.data["accessToken"];
        // 리퀘스트 옶션이 뭐였는지 그대로 받아볼 수 있다
        final options = err.requestOptions;
        options.headers.addAll({
          "Authorization": "Bearer $accessToken",
        });
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 다시 발급 받은 accessToken으로
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } on DioError catch (e) {
        ref.read(authProvider.notifier).logout();
        return handler.reject(e);
      }
    }

    return handler.reject(err);
  }
}
