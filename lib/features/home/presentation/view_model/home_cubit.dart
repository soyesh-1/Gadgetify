import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void changeTab(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  // This method simulates loading the data for the home screen.
  void loadHomeData() {
    emit(state.copyWith(isLoading: true));

    // In the future, this data will come from a UseCase calling a Repository.
    final categories = [
      {'icon': CupertinoIcons.device_phone_portrait, 'name': 'Phones'},
      {'icon': CupertinoIcons.device_laptop, 'name': 'Laptops'},
      {'icon': CupertinoIcons.headphones, 'name': 'Audio'},
      {'icon': CupertinoIcons.game_controller, 'name': 'Gaming'},
      {'icon': CupertinoIcons.camera, 'name': 'Cameras'},
    ];

    final specialForYou = [
      {
        'name': 'Smart Watch X',
        'price': '\$299',
        'image': 'https://placehold.co/300x300/F0F0F0/333333?text=Watch+X',
      },
      {
        'name': 'Pro Headphones',
        'price': '\$199',
        'image': 'https://placehold.co/300x300/E0E0E0/333333?text=Headphones',
      },
      {
        'name': 'VR Headset',
        'price': '\$499',
        'image': 'https://placehold.co/300x300/D0D0D0/333333?text=VR',
      },
    ];

    final popularProducts = [
      {
        'name': 'Gaming Mouse',
        'price': '\$79',
        'image': 'https://placehold.co/300x300/C0C0C0/333333?text=Mouse',
      },
      {
        'name': '4K Drone',
        'price': '\$899',
        'image': 'https://placehold.co/300x300/B0B0B0/333333?text=Drone',
      },
      {
        'name': 'Tablet Pro',
        'price': '\$649',
        'image': 'https://placehold.co/300x300/A0A0A0/333333?text=Tablet',
      },
      {
        'name': 'Smart Speaker',
        'price': '\$129',
        'image': 'https://placehold.co/300x300/909090/333333?text=Speaker',
      },
    ];

    emit(
      state.copyWith(
        isLoading: false,
        categories: categories,
        specialForYouProducts: specialForYou,
        popularProducts: popularProducts,
      ),
    );
  }
}
