import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:gadgetify/features/auth/presentation/view_model/auth_state.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _nameController = TextEditingController(); // <-- ADDED
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // ... (rest of the state class is the same)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess && !state.isLogin) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sign Up successful! Please log in.'),
              ),
            );
            Navigator.pop(context);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Container(
          // ... (Container decoration is the same)
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // --- ADDED NAME TEXTFIELD ---
                  TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: _buildInputDecoration('Full Name'),
                  ),
                  const SizedBox(height: 16),

                  // ---------------------------
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: _buildInputDecoration('Email Address'),
                  ),
                  const SizedBox(height: 16),

                  // ... (Password and Confirm Password TextFields are the same)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          // ... (Loading button is the same)
                        }
                        return ElevatedButton(
                          onPressed: () {
                            // --- UPDATED to send the name ---
                            context.read<AuthCubit>().signUp(
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              confirmPassword: _confirmPasswordController.text,
                            );
                          },
                          // ... (Button style is the same)
                          child: const Text('Sign Up'),
                        );
                      },
                    ),
                  ),
                  // ... (Rest of the UI is the same)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method, no changes needed
  InputDecoration _buildInputDecoration(String hintText, {Widget? icon}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white70),
      suffixIcon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
