import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:order/common/view/root_tab.dart';
import 'package:order/order/view/order_done_screen.dart';
import 'package:order/order/view/order_screen.dart';
import 'package:order/restaurant/view/basket_screen.dart';
import 'package:order/restaurant/view/restaurant_detail_screen.dart';
import 'package:order/user/model/user_model.dart';
import 'package:order/user/provider/user_me_provider.dart';
import 'package:order/user/view/login_screen.dart';
import 'package:order/user/view/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(userMeProvider);

  return GoRouter(
    initialLocation: "/",
    redirect: (context, state) {
      if (user == null) {
        return "/login";
      }

      if (user is UserModelError) {
        return "/";
      }
      return null;
    },
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const RootTab(),
        routes: [
          GoRoute(
            path: "splash",
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            path: "login",
            builder: (context, state) => const LoginScreen(),
            redirect: (context, state) {
              if (user is UserModel) {
                return state.location == "/login" || state.location == "/splash"
                    ? "/"
                    : null;
              }
              return null;
            },
          ),
          GoRoute(
            path: "restaurant/:id",
            builder: (context, state) =>
                RestaurantDetailScreen(id: state.pathParameters["id"]!),
          ),
          GoRoute(
            path: "basket",
            builder: (context, state) => const BasketScreen(),
          ),
          GoRoute(
            path: "order_done",
            builder: (context, state) => const OrderDoneScreen(),
          ),
          GoRoute(
            path: "order",
            builder: (context, state) => const OrderScreen(),
          ),
        ],
      )
    ],
  );
});
