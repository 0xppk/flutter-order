import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:order/common/const/colors.dart';
import 'package:order/common/layout/root_layout.dart';
import 'package:order/common/model/cursor_pagination_model.dart';
import 'package:order/common/utils/pagination_utils.dart';
import 'package:order/product/components/product_card.dart';
import 'package:order/product/model/product_model.dart';
import 'package:order/rating/components/rating_card.dart';
import 'package:order/rating/model/rating_model.dart';
import 'package:order/restaurant/components/restaurant_card.dart';
import 'package:order/restaurant/model/restaurant_detail_model.dart';
import 'package:order/restaurant/model/restaurant_model.dart';
import 'package:order/restaurant/provider/restaurant_provider.dart';
import 'package:order/restaurant/provider/restaurant_rating_provider.dart';
import 'package:order/user/provider/basket_provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:badges/badges.dart' as badges;

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
    controller.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(restaurantRatingProvider(widget.id).notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingState = ref.watch(restaurantRatingProvider(widget.id));
    final basket = ref.watch(basketProvider);

    return RootLayout(
      title: "혜조",
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push("/basket");
        },
        backgroundColor: PRIMARY_COLOR,
        child: badges.Badge(
          badgeStyle: const badges.BadgeStyle(
            badgeColor: Colors.white,
          ),
          showBadge: basket.isNotEmpty,
          badgeContent: Text(
            basket
                .fold<int>(0, (previous, next) => previous + next.count)
                .toString(),
            style: const TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 10,
            ),
          ),
          child: const Icon(
            Icons.shopping_basket_outlined,
          ),
        ),
      ),
      child: state != null
          ? CustomScrollView(
              controller: controller,
              slivers: [
                renderRestaurantCard(
                  model: state,
                  isDetail: true,
                ),
                if (state is! RestaurantDetailModel) renderLoading(),
                if (state is RestaurantDetailModel) renderLabel(),
                if (state is RestaurantDetailModel)
                  renderProducts(
                    products: state.products,
                    restaurant: state,
                  ),
                if (ratingState is CursorPagination<RatingModel>)
                  renderRatings(models: ratingState.data)
              ],
            )
          : const CircularProgressIndicator(),
    );
  }

  SliverPadding renderRatings({
    required List<RatingModel> models,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => RatingCard.fromModel(model: models[index]),
          childCount: models.length,
        ),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: Text(
          "메뉴",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  SliverToBoxAdapter renderRestaurantCard({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        item: model,
        isDetail: isDetail,
      ),
    );
  }

  SliverPadding renderProducts({
    required List<RestaurantProductModel> products,
    required RestaurantModel restaurant,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];

            return InkWell(
              onTap: () {
                ref.read(basketProvider.notifier).addToBasket(
                      product: ProductModel(
                        id: product.id,
                        name: product.name,
                        detail: product.detail,
                        imgUrl: product.imgUrl,
                        price: product.price,
                        restaurant: restaurant,
                      ),
                    );
              },
              child: SafeArea(
                child: ProductCard.fromRestaurantProductModel(
                  item: product,
                ),
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
