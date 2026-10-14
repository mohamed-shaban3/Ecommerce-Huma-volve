import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class CategoryLoadingState extends HomeStates {}

class CategorySuccessState extends HomeStates {
  final List<HomeCategoryEntity> categories;
  CategorySuccessState(this.categories);
}

class CategoryErrorState extends HomeStates {
  final String errorMessage;
  CategoryErrorState(this.errorMessage);
}

class ProductLoadingState extends HomeStates {}

class ProductSuccessState extends HomeStates {
  final List<HomeProductEntity> products;
  ProductSuccessState(this.products);
}

class ProductErrorState extends HomeStates {
  final String errorMessage;
  ProductErrorState(this.errorMessage);
}



