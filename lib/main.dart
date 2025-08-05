import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/router/app_router.dart';
import 'package:gadgetify/app/service_locator/service_locator.dart';
import 'package:gadgetify/features/auth/data/model/auth_hive_model.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:gadgetify/features/cart/data/model/cart_item_hive_model.dart';
import 'package:gadgetify/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:gadgetify/features/products/presentation/view_model/search_cubit.dart';
import 'package:gadgetify/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:gadgetify/features/wishlist/data/model/wishlist_item_hive_model.dart';
import 'package:gadgetify/features/wishlist/presentation/view_model/wishlist_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(AuthHiveModelAdapter());
  Hive.registerAdapter(CartItemHiveModelAdapter());
  Hive.registerAdapter(WishlistItemHiveModelAdapter());
  setupDependencies();
  runApp(const GadgetApp());
}

class GadgetApp extends StatelessWidget {
  const GadgetApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(create: (_) => sl<SplashCubit>()),
        BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()),
        BlocProvider<CartCubit>(create: (_) => sl<CartCubit>()..getCartItems()),
        BlocProvider<WishlistCubit>(
          create: (_) => sl<WishlistCubit>()..getWishlistItems(),
        ),
        // ✅ ADDED: Provide SearchCubit globally
        BlocProvider<SearchCubit>(create: (_) => sl<SearchCubit>()),
      ],
      child: MaterialApp(
        title: 'Gadgetify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        initialRoute: AppRouter.splashRoute,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
