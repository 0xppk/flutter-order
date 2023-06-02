import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order/common/const/data.dart';
import 'package:order/provider/dio_provider.dart';
import 'package:order/user/model/basket_item_model.dart';
import 'package:order/user/model/patch_basket_body.dart';
import 'package:order/user/model/user_model.dart';
import 'package:retrofit/http.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return UserMeRepository(dio, baseUrl: "$baseUrl/user/me");
});

@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(
    Dio dio, {
    String baseUrl,
  }) = _UserMeRepository;

  @GET("/")
  @Headers({
    "accessToken": "true",
  })
  Future<UserModel> getMe();

  @GET("/basket")
  @Headers({
    "accessToken": "true",
  })
  Future<List<BasketItemModel>> getBasket();

  @PATCH("/basket")
  @Headers({
    "accessToken": "true",
  })
  Future<List<BasketItemModel>> patchBasket({
    @Body() required PatchBasketBody body,
  });
}
