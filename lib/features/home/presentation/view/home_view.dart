import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/router/app_router.dart';
import 'package:gadgetify/app/service_locator/service_locator.dart';
import 'package:gadgetify/features/auth/data/data_source/local_datasource/auth_local_data_source.dart';
import 'package:gadgetify/features/home/domain/entity/category_entity.dart';
import 'package:gadgetify/features/home/presentation/view_model/home_cubit.dart';
import 'package:gadgetify/features/home/presentation/view_model/home_state.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/features/wishlist/presentation/view_model/wishlist_cubit.dart';
import 'package:gadgetify/features/wishlist/presentation/view_model/wishlist_state.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late StreamSubscription _accelerometerSub;
  DateTime? _lastShakeTime;

  @override
  void initState() {
    super.initState();

    _accelerometerSub = userAccelerometerEvents.listen((event) {
      const shakeThreshold = 25.0;
      double acceleration = sqrt(
        event.x * event.x + event.y * event.y + event.z * event.z,
      );
      final now = DateTime.now();

      if (acceleration > shakeThreshold &&
          (_lastShakeTime == null ||
              now.difference(_lastShakeTime!) > const Duration(seconds: 2))) {
        _lastShakeTime = now;
        Navigator.pushNamed(context, AppRouter.profileRoute);
      }
    });
  }

  @override
  void dispose() {
    _accelerometerSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HomeCubit>()..getAllData()),
        BlocProvider(create: (_) => sl<WishlistCubit>()..getWishlistItems()),
      ],
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: BlocBuilder<HomeCubit, HomeState>(builder: _buildHomeBody),
        bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return _buildBottomNavigationBar(
              context: context,
              selectedIndex: state.selectedIndex,
            );
          },
        ),
      ),
    );
  }

  Widget _buildHomeBody(BuildContext context, HomeState state) {
    if (state.isLoading && state.products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.error != null) {
      return Center(child: Text('Error: ${state.error}'));
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeCubit>().getAllData();
        context.read<WishlistCubit>().getWishlistItems();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(context),
            const SizedBox(height: 24),
            _buildBanner(),
            const SizedBox(height: 24),
            _buildSectionTitle('Categories'),
            const SizedBox(height: 16),
            _buildCategories(context, state.categories),
            const SizedBox(height: 24),
            _buildSectionTitle('Special for You'),
            const SizedBox(height: 16),
            _buildSpecialForYou(context, state.products),
            const SizedBox(height: 24),
            _buildSectionTitle('Popular Products'),
            const SizedBox(height: 16),
            _buildPopularProducts(context, state.products),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'Gadgetify',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(CupertinoIcons.bell, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.black),
          onPressed: () async {
            final authLocalDataSource = sl<AuthLocalDataSource>();
            await authLocalDataSource.deleteToken();
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.loginRoute,
              (route) => false,
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://placehold.co/100x100/EFEFEF/333333?text=User',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    // Add context
    return TextField(
      onSubmitted: (query) {
        if (query.isNotEmpty) {
          Navigator.pushNamed(context, AppRouter.searchRoute, arguments: query);
        }
      },
      decoration: InputDecoration(
        hintText: 'Search for gadgets...',
        prefixIcon: const Icon(CupertinoIcons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        gradient: const LinearGradient(
          colors: [Colors.indigo, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Latest Gadgets!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Up to 30% OFF',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCategories(
    BuildContext context,
    List<CategoryEntity> categories,
  ) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRouter.productByCategoryRoute,
                arguments: category.name,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(category.icon, color: Colors.indigo, size: 30),
                  ),
                  const SizedBox(height: 8),
                  Text(category.name, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpecialForYou(
    BuildContext context,
    List<ProductEntity> products,
  ) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length > 3 ? 3 : products.length,
        itemBuilder:
            (ctx, index) => _buildProductCard(context, products[index]),
      ),
    );
  }

  Widget _buildPopularProducts(
    BuildContext context,
    List<ProductEntity> products,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: products.length,
      itemBuilder:
          (ctx, index) =>
              _buildProductCard(context, products[index], isPopular: true),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    ProductEntity product, {
    bool isPopular = false,
  }) {
    final imageUrl = 'http://192.168.1.80:5005${product.image}';

    return GestureDetector(
      onTap: () {
        if (product.id != null) {
          Navigator.pushNamed(
            context,
            AppRouter.productDetailRoute,
            arguments: product.id!,
          );
        }
      },
      child: Container(
        width: isPopular ? null : 160,
        margin: isPopular ? null : const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12.0),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder:
                          (context, error, stackTrace) => const Center(
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: BlocBuilder<WishlistCubit, WishlistState>(
                      builder: (context, state) {
                        if (product.id == null) return const SizedBox.shrink();
                        final isFavorite = context
                            .read<WishlistCubit>()
                            .isFavorite(product.id!);
                        return GestureDetector(
                          onTap: () {
                            if (isFavorite) {
                              context.read<WishlistCubit>().removeFromWishlist(
                                product.id!,
                              );
                            } else {
                              context.read<WishlistCubit>().addToWishlist(
                                product.id!,
                              );
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.7),
                            radius: 15,
                            child: Icon(
                              isFavorite
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: isFavorite ? Colors.red : Colors.grey,
                              size: 20,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'NPR ${product.price}',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar({
    required BuildContext context,
    required int selectedIndex,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            // Note: HomeCubit handles changing the selectedIndex for the Home tab (index 0).
            // For other tabs, we directly navigate to their respective routes.
            if (index == 0) {
              context.read<HomeCubit>().changeTab(index);
              return;
            }
            switch (index) {
              case 1:
                Navigator.pushNamed(context, AppRouter.wishlistRoute);
                break;
              case 2:
                Navigator.pushNamed(context, AppRouter.cartRoute);
                break;
              case 3:
                Navigator.pushNamed(context, AppRouter.profileRoute);
                break;
            }
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
        ),
      ),
    );
  }
}
