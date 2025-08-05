import 'package:equatable/equatable.dart';

// Using CupertinoIcons for consistency with your HomeView
import 'package:flutter/cupertino.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final IconData icon;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, name, icon];
}
