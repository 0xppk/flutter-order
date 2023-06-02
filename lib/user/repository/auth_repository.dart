import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order/common/const/data.dart';
import 'package:order/common/model/login_response.dart';
import 'package:order/common/model/token_response.dart';
import 'package:order/common/utils/data_utils.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = Dio();
  return AuthRepository(dio, baseUrl: "$baseUrl/auth");
});

class AuthRepository {
  final String baseUrl;
  final Dio dio;

  AuthRepository(
    this.dio, {
    required this.baseUrl,
  });

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final serialized = await DataUtils.plainToBase64("$username:$password");
    final res = await dio.post(
      "$baseUrl/login",
      options: Options(
        headers: {
          "authorization": "Basic $serialized",
        },
      ),
    );

    return LoginResponse.fromJson(res.data);
  }

  Future<TokenResponse> token() async {
    final res = await dio.post(
      "$baseUrl/token",
      options: Options(
        headers: {
          "refreshToken": "true",
        },
      ),
    );

    return TokenResponse.fromJson(res.data);
  }
}
