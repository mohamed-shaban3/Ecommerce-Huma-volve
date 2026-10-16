import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';

class HomeProductModel extends HomeProductEntity {


  HomeProductModel(
    {
      super.id,
      super.title,
      super.slug,
      super.price,
      super.description,
      super.category,
      super.images,

      });

HomeProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0;
    title = json['title']?.toString() ?? '';
    slug = json['slug']?.toString() ?? '';
    price = json['price'] is int 
        ? json['price'] 
        : (json['price'] as num?)?.toInt() ?? 0;
    description = json['description']?.toString() ?? '';
    
    category = json['category'] != null && json['category'] is Map<String, dynamic>
        ? HomeCategoryModel.fromJson(json['category'])
        : null;
        
    if (json['images'] != null && json['images'] is List) {
      images = List<String>.from(json['images'].map((x) => x?.toString() ?? ''));
    } else if (json['images'] != null && json['images'] is String) {
      images = [json['images']];
    } else {
      images = [];
    }
  }

}
