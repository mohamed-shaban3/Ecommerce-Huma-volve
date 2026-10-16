class ProductDetailsEntity {
  final int? id;
  final String? title;
  final num? price;
  final String? description;
  final List<String>? images;

  const ProductDetailsEntity({
    this.id,
    this.title,
    this.price,
    this.description,
    this.images,
  });
}