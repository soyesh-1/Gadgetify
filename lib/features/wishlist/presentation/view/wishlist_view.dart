// ... (imports)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/service_locator/service_locator.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/app/router/app_router.dart';
import 'package:gadgetify/features/wishlist/presentation/view_model/wishlist_cubit.dart';
import 'package:gadgetify/features/wishlist/presentation/view_model/wishlist_state.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WishlistCubit>()..getWishlistItems(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Wishlist'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }
            if (state.products.isEmpty) {
              return const Center(child: Text('Your wishlist is empty.'));
            }
            // ✅ UPDATED: Display products in a grid
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(context, state.products[index]);
              },
            );
          },
        ),
      ),
    );
  }

  // Reusable product card widget
  Widget _buildProductCard(BuildContext context, ProductEntity product) {
    final imageUrl = 'http://192.168.1.80:5005${product.image}';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.productDetailRoute,
          arguments: product.id,
        );
      },
      child: Container(
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
              child: ClipRRect(
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
}
