import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/router/app_router.dart';
import 'package:gadgetify/app/service_locator/service_locator.dart';
import 'package:gadgetify/features/products/domain/entity/product_entity.dart';
import 'package:gadgetify/features/products/presentation/view_model/search_cubit.dart';
import 'package:gadgetify/features/products/presentation/view_model/search_state.dart';
import 'package:gadgetify/features/wishlist/presentation/view_model/wishlist_cubit.dart';
import 'package:gadgetify/features/wishlist/presentation/view_model/wishlist_state.dart';

class SearchView extends StatelessWidget {
  final String searchQuery;
  const SearchView({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SearchCubit>()..performSearch(searchQuery),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search Results for "$searchQuery"'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }
            if (state.searchResults.isEmpty) {
              return const Center(child: Text('No products found.'));
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: state.searchResults.length,
              itemBuilder: (context, index) {
                return _buildProductCard(context, state.searchResults[index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductEntity product) {
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
}
