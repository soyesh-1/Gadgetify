import 'package:gadgetify/features/products/domain/entity/product_entity.dart';

class SpecificationModel {
  final String name;
  final String value;

  SpecificationModel({required this.name, required this.value});

  factory SpecificationModel.fromJson(Map<String, dynamic> json) {
    return SpecificationModel(name: json['name'], value: json['value']);
  }

  SpecificationEntity toEntity() {
    return SpecificationEntity(name: name, value: value);
  }
}

class ProductModel {
  final String id;
  final String name;
  final int price;
  final String description;
  final String image;
  final String category;
  final int stock;
  final List<SpecificationModel> specifications;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.stock,
    required this.specifications,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    var specList =
        (json['specifications'] as List)
            .map((spec) => SpecificationModel.fromJson(spec))
            .toList();

    return ProductModel(
      id: json['_id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      image: json['image'],
      category: json['category'],
      stock: json['stock'],
      specifications: specList,
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      price: price,
      description: description,
      image: image,
      category: category,
      stock: stock,
      specifications: specifications.map((spec) => spec.toEntity()).toList(),
    );
  }
}
