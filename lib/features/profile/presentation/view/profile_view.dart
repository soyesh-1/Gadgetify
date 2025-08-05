// lib/features/profile/presentation/view/profile_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/service_locator/service_locator.dart';
// UPDATED import
import 'package:gadgetify/features/auth/domain/entity/auth_entity.dart'; 
import 'package:gadgetify/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:gadgetify/features/profile/presentation/view_model/profile_state.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfileCubit>()..fetchProfileData(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('My Profile'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<ProfileCubit>().fetchProfileData();
              },
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  if (state.user != null) _buildUserInfoCard(state.user!),
                  const SizedBox(height: 24),
                  const Text(
                    'Order History',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 24),
                  if (state.orders.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(child: Text('You have no past orders.')),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.orders.length,
                      itemBuilder: (ctx, index) {
                        final order = state.orders[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                          child: ListTile(
                            title: Text('Order #${order.id.substring(0, 8)}...'),
                            subtitle: Text(
                                'Date: ${order.createdAt.toLocal().toString().split(' ')[0]}'),
                            trailing: Text(
                              'NPR ${order.totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // UPDATED to accept AuthEntity
  Widget _buildUserInfoCard(AuthEntity user) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://placehold.co/100x100/EFEFEF/333333?text=User'),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(user.email,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}