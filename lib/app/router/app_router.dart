import 'package:flutter/material.dart';
import 'package:gadgetify/features/auth/presentation/view/login_view.dart';
import 'package:gadgetify/features/auth/presentation/view/signup_view.dart';
import 'package:gadgetify/features/cart/presentation/view/cart_view.dart';
import 'package:gadgetify/features/checkout/presentation/view/checkout_view.dart';
import 'package:gadgetify/features/home/presentation/view/home_view.dart';
import 'package:gadgetify/features/products/presentation/view/product_by_category_view.dart';
import 'package:gadgetify/features/products/presentation/view/product_detail_view.dart';
import 'package:gadgetify/features/products/presentation/view/search_view.dart';
import 'package:gadgetify/features/profile/presentation/view/profile_view.dart';
import 'package:gadgetify/features/splash/presentation/view/splash_view.dart';
import 'package:gadgetify/features/wishlist/presentation/view/wishlist_view.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';
  static const String productDetailRoute = '/product-detail';
  static const String cartRoute = '/cart';
  static const String profileRoute = '/profile';
  static const String productByCategoryRoute = '/product-by-category';
  static const String wishlistRoute = '/wishlist';
  static const String checkoutRoute = '/checkout';
  static const String searchRoute = '/search';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case productDetailRoute:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProductDetailView(productId: productId),
        );
      case cartRoute:
        return MaterialPageRoute(builder: (_) => const CartView());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case productByCategoryRoute:
        final categoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ProductByCategoryView(categoryName: categoryName),
        );
      case wishlistRoute:
        return MaterialPageRoute(builder: (_) => const WishlistView());
      case checkoutRoute:
        return MaterialPageRoute(builder: (_) => const CheckoutView());

      // ✅ CORRECTED: Get the search query from arguments and pass it to the view
      case searchRoute:
        final query = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => SearchView(searchQuery: query),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}