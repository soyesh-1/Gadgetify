import 'package:equatable/equatable.dart';

class SpecificationEntity extends Equatable {
  final String name;
  final String value;

  const SpecificationEntity({required this.name, required this.value});

  @override
  List<Object?> get props => [name, value];
}

class ProductEntity extends Equatable {
  final String? id;
  final String name;
  final int price;
  final String description;
  final String image;
  final String category;
  final int stock;
  final List<SpecificationEntity> specifications;

  const ProductEntity({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.stock,
    required this.specifications,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    description,
    image,
    category,
    stock,
    specifications,
  ];
}
