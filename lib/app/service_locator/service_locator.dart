import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:gadgetify/core/network/dio_provider.dart';
import 'package:gadgetify/core/network/network_info.dart';

// Auth
import 'package:gadgetify/features/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:gadgetify/features/auth/data/data_source/remote_datasource/auth_remote_data_source.dart';
import 'package:gadgetify/features/auth/data/repository/auth_repository_impl.dart';
import 'package:gadgetify/features/auth/domain/repository/auth_repository.dart';
import 'package:gadgetify/features/auth/domain/use_case/login_use_case.dart';
import 'package:gadgetify/features/auth/domain/use_case/signup_use_case.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_cubit.dart';

// Products
import 'package:gadgetify/features/products/data/data_source/remote_datasource/product_remote_data_source.dart';
import 'package:gadgetify/features/products/data/repository/product_repository_impl.dart';
import 'package:gadgetify/features/products/domain/repository/product_repository.dart';
import 'package:gadgetify/features/products/domain/use_case/get_all_products_use_case.dart';
import 'package:gadgetify/features/products/domain/use_case/get_product_by_id_use_case.dart';
import 'package:gadgetify/features/products/domain/use_case/get_products_by_category_use_case.dart';
import 'package:gadgetify/features/products/domain/use_case/search_products_use_case.dart';
import 'package:gadgetify/features/products/presentation/view_model/product_by_category_cubit.dart';
import 'package:gadgetify/features/products/presentation/view_model/product_detail_cubit.dart';
import 'package:gadgetify/features/products/presentation/view_model/search_cubit.dart';

// Cart
import 'package:gadgetify/features/cart/data/data_source/local_datasource/cart_local_data_source.dart';
import 'package:gadgetify/features/cart/data/repository/cart_repository_impl.dart';
import 'package:gadgetify/features/cart/domain/repository/cart_repository.dart';
import 'package:gadgetify/features/cart/domain/use_case/add_cart_item_use_case.dart';
import 'package:gadgetify/features/cart/domain/use_case/get_all_cart_items_use_case.dart';
import 'package:gadgetify/features/cart/domain/use_case/remove_cart_item_use_case.dart';
import 'package:gadgetify/features/cart/presentation/view_model/cart_cubit.dart';

// Checkout
import 'package:gadgetify/features/checkout/data/data_source/remote_datasource/checkout_remote_data_source.dart';
import 'package:gadgetify/features/checkout/data/repository/checkout_repository_impl.dart';
import 'package:gadgetify/features/checkout/domain/repository/checkout_repository.dart';
import 'package:gadgetify/features/checkout/domain/use_case/create_order_use_case.dart';
import 'package:gadgetify/features/checkout/presentation/view_model/checkout_cubit.dart';

// Profile
import 'package:gadgetify/features/profile/data/data_source/remote_datasource/profile_remote_data_source.dart';
import 'package:gadgetify/features/profile/data/repository/profile_repository_impl.dart';
import 'package:gadgetify/features/profile/domain/repository/profile_repository.dart';
import 'package:gadgetify/features/profile/domain/use_case/get_my_orders_usecase.dart';
import 'package:gadgetify/features/profile/presentation/view_model/profile_cubit.dart';

// Wishlist
import 'package:gadgetify/features/wishlist/data/data_source/local_datasource/wishlist_local_data_source.dart';
import 'package:gadgetify/features/wishlist/data/repository/wishlist_repository_impl.dart';
import 'package:gadgetify/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:gadgetify/features/wishlist/domain/use_case/add_to_wishlist_use_case.dart';
import 'package:gadgetify/features/wishlist/domain/use_case/get_all_wishlist_items_use_case.dart';
import 'package:gadgetify/features/wishlist/domain/use_case/get_wishlist_products_use_case.dart';
import 'package:gadgetify/features/wishlist/domain/use_case/remove_from_wishlist_use_case.dart';
import 'package:gadgetify/features/wishlist/presentation/view_model/wishlist_cubit.dart';

// Home & Splash
import 'package:gadgetify/features/home/presentation/view_model/home_cubit.dart';
import 'package:gadgetify/features/splash/presentation/view_model/splash_cubit.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // Core
  sl.registerLazySingleton<Dio>(() => createDio());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfo(sl()));

  // Auth
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(sl(), sl(), sl()),
  );
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(signUpUseCase: sl(), loginUseCase: sl()),
  );

  // Products
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<IProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<GetAllProductsUseCase>(
    () => GetAllProductsUseCase(sl()),
  );
  sl.registerLazySingleton<GetProductByIdUseCase>(
    () => GetProductByIdUseCase(sl()),
  );
  sl.registerLazySingleton<GetProductsByCategoryUseCase>(
    () => GetProductsByCategoryUseCase(sl()),
  );
  sl.registerLazySingleton<SearchProductsUseCase>(
    () => SearchProductsUseCase(sl()),
  );

  sl.registerFactory<ProductDetailCubit>(() => ProductDetailCubit(sl()));
  sl.registerFactory<ProductByCategoryCubit>(
    () => ProductByCategoryCubit(sl()),
  );
  sl.registerFactory<SearchCubit>(() => SearchCubit(sl()));

  // Cart
  sl.registerLazySingleton<CartLocalDataSource>(() => CartLocalDataSource());
  sl.registerLazySingleton<ICartRepository>(() => CartRepositoryImpl(sl()));
  sl.registerLazySingleton<GetAllCartItemsUseCase>(
    () => GetAllCartItemsUseCase(sl()),
  );
  sl.registerLazySingleton<AddCartItemUseCase>(() => AddCartItemUseCase(sl()));
  sl.registerLazySingleton<RemoveCartItemUseCase>(
    () => RemoveCartItemUseCase(sl()),
  );
  sl.registerLazySingleton<CartCubit>(
    () => CartCubit(
      getAllCartItemsUseCase: sl(),
      addCartItemUseCase: sl(),
      removeCartItemUseCase: sl(),
    ),
  );

  // Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<IProfileRepository>(
    () => ProfileRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<GetMyOrdersUseCase>(() => GetMyOrdersUseCase(sl()));
  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(getMyOrdersUseCase: sl(), authLocalDataSource: sl()),
  );

  // Checkout
  sl.registerLazySingleton<CheckoutRemoteDataSource>(
    () => CheckoutRemoteDataSource(sl(), sl()),
  );
  sl.registerLazySingleton<ICheckoutRepository>(
    () => CheckoutRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CreateOrderUseCase>(() => CreateOrderUseCase(sl()));
  sl.registerFactory<CheckoutCubit>(() => CheckoutCubit(sl(), sl()));

  // Wishlist
  sl.registerLazySingleton<WishlistLocalDataSource>(
    () => WishlistLocalDataSource(),
  );
  sl.registerLazySingleton<IWishlistRepository>(
    () => WishlistRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AddToWishlistUseCase>(
    () => AddToWishlistUseCase(sl()),
  );
  sl.registerLazySingleton<RemoveFromWishlistUseCase>(
    () => RemoveFromWishlistUseCase(sl()),
  );
  sl.registerLazySingleton<GetAllWishlistItemsUseCase>(
    () => GetAllWishlistItemsUseCase(sl()),
  );
  sl.registerLazySingleton<GetWishlistProductsUseCase>(
    () => GetWishlistProductsUseCase(sl()),
  );
  sl.registerFactory<WishlistCubit>(
    () => WishlistCubit(
      addToWishlistUseCase: sl(),
      removeFromWishlistUseCase: sl(),
      getAllWishlistItemsUseCase: sl(),
      getWishlistProductsUseCase: sl(),
    ),
  );

  // Home & Splash
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl()));
  sl.registerFactory<SplashCubit>(() => SplashCubit(sl()));
}
