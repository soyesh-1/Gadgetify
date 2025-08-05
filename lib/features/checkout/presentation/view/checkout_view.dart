import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/app/service_locator/service_locator.dart';
import 'package:gadgetify/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:gadgetify/features/cart/presentation/view_model/cart_state.dart';
import 'package:gadgetify/features/checkout/domain/entity/shipping_info_entity.dart';
import 'package:gadgetify/features/checkout/presentation/view_model/checkout_cubit.dart';
import 'package:gadgetify/features/checkout/presentation/view_model/checkout_state.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _gap = const SizedBox(height: 12);
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CheckoutCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state.isOrderPlaced) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order placed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              // Go back to the home screen after a successful order
              Navigator.popUntil(context, (route) => route.isFirst);
            }
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, checkoutState) {
            return BlocBuilder<CartCubit, CartState>(
              builder: (context, cartState) {
                if (cartState.cartItems.isEmpty &&
                    !checkoutState.isOrderPlaced) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  });
                  return const SizedBox.shrink();
                }
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Order Summary',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartState.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartState.cartItems[index];
                            final imageUrl =
                                'http://10.0.2.2:5005${item.image}';
                            return ListTile(
                              leading: Image.network(
                                imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Icon(Icons.broken_image),
                              ),
                              title: Text(item.name),
                              subtitle: Text('Qty: ${item.quantity}'),
                              trailing: Text(
                                'NPR ${item.price * item.quantity}',
                              ),
                            );
                          },
                        ),
                        const Divider(height: 32),
                        const Text(
                          'Shipping Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                          ),
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? 'Please enter your name'
                                      : null,
                        ),
                        _gap,
                        TextFormField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(),
                          ),
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? 'Please enter your address'
                                      : null,
                        ),
                        _gap,
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? 'Please enter your phone number'
                                      : null,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Payment Method',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Column(
                            children: [
                              const Text(
                                'Scan QR to Pay with Esewa (Test Mode)',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // ✅ UPDATED: Using Image.asset for your local QR code
                              Image.asset(
                                'assets/images/esewa.jpg', // Path to your QR image
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                                errorBuilder:
                                    (context, error, stackTrace) => const Icon(
                                      Icons.qr_code_2,
                                      size: 200,
                                      color: Colors.grey,
                                    ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, checkoutState) {
            return BlocBuilder<CartCubit, CartState>(
              builder: (context, cartState) {
                if (cartState.cartItems.isEmpty) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed:
                        checkoutState.isLoading
                            ? null
                            : () {
                              if (_formKey.currentState!.validate()) {
                                final shippingInfo = ShippingInfoEntity(
                                  fullName: _nameController.text,
                                  address: _addressController.text,
                                  phoneNo: _phoneController.text,
                                );
                                // Simulate payment success and place order
                                context.read<CheckoutCubit>().placeOrder(
                                  cartItems: cartState.cartItems,
                                  shippingInfo: shippingInfo,
                                );
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child:
                        checkoutState.isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'I have Paid',
                            ), // ✅ Changed button text
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
