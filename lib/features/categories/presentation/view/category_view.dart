import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/router/app_router.dart';
import 'package:gadgetify/app/service_locator/service_locator.dart';
import 'package:gadgetify/features/categories/presentation/view_model/category_cubit.dart';
import 'package:gadgetify/features/categories/presentation/view_model/category_state.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CategoryCubit>()..getAllCategories(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Categories'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return ListTile(
                  leading: Icon(category.icon, color: Colors.indigo),
                  title: Text(
                    category.name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.productByCategoryRoute,
                      arguments: category.name,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
