import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order/common/model/cursor_pagination_model.dart';
import 'package:order/provider/pagination_provider.dart';
import 'package:order/rating/model/rating_model.dart';
import 'package:order/restaurant/repository/restaurant_rating_repository.dart';

final restaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingStateNotifier, CursorPaginationBase, String>((ref, id) {
  final repo = ref.watch(restaurantRatingRepositoryProvider(id));

  return RestaurantRatingStateNotifier(repository: repo);
});

class RestaurantRatingStateNotifier
    extends PaginationProvider<RatingModel, RestaurantRatingRepository> {
  RestaurantRatingStateNotifier({
    required super.repository,
  });
}
