import 'package:ecommerce_app_huma_volve/features/home/services/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/product_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class CategoryLoadingState extends HomeStates {}

class CategorySuccessState extends HomeStates {
  final List<CategoryModel> categories;
  CategorySuccessState(this.categories);
}

class CategoryErrorState extends HomeStates {
  final String errorMessage;
  CategoryErrorState(this.errorMessage);
}

class ProductLoadingState extends HomeStates {}

class ProductSuccessState extends HomeStates {
  final List<ProductModel> products;
  ProductSuccessState(this.products);
}

class ProductErrorState extends HomeStates {
  final String errorMessage;
  ProductErrorState(this.errorMessage);
}



