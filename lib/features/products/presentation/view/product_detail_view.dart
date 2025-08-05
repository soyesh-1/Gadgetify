import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/service_locator/service_locator.dart';
import 'package:gadgetify/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/features/products/presentation/view_model/product_detail_cubit.dart';
import 'package:gadgetify/features/products/presentation/view_model/product_detail_state.dart';
import 'package:gadgetify/features/wishlist/presentation/view_model/wishlist_cubit.dart';
import 'package:gadgetify/features/wishlist/presentation/view_model/wishlist_state.dart';

class ProductDetailView extends StatelessWidget {
  final String productId;

  const ProductDetailView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    // This screen only needs to create the ProductDetailCubit.
    // It will read the existing WishlistCubit from the context.
    return BlocProvider(
      create: (context) => sl<ProductDetailCubit>()..getProductById(productId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          actions: [
            // This BlocBuilder listens to the globally provided WishlistCubit
            BlocBuilder<WishlistCubit, WishlistState>(
              builder: (context, state) {
                final isFavorite = context.read<WishlistCubit>().isFavorite(
                  productId,
                );
                return IconButton(
                  icon: Icon(
                    isFavorite
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    if (isFavorite) {
                      context.read<WishlistCubit>().removeFromWishlist(
                        productId,
                      );
                    } else {
                      context.read<WishlistCubit>().addToWishlist(productId);
                    }
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }
            if (state.product == null) {
              return const Center(child: Text('Product not found.'));
            }
            return _buildProductDetails(context, state.product!);
          },
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context, ProductEntity product) {
    final imageUrl = 'http://192.168.1.80:5005${product.image}';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.error_outline, size: 50)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'NPR ${product.price}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<CartCubit>().addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} added to cart!'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: const Icon(CupertinoIcons.shopping_cart),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Specifications',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                ...product.specifications.map(
                  (spec) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          spec.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          spec.value,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
