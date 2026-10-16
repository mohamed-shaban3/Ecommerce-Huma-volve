import '../../domain/entities/product_details_entity.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  const ProductDetailsModel({
    super.id,
    super.title,
    super.price,
    super.description,
    super.images,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title']?.toString() ?? '',
      price: json['price'] is int ? json['price'] : (json['price'] as num?),
      description: json['description']?.toString() ?? '',
      images: json['images'] != null && json['images'] is List
          ? List<String>.from(json['images'].map((x) => x?.toString() ?? ''))
          : [],
    );
  }
}