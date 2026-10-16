import 'package:ecommerce_app_huma_volve/features/details/domain/entities/product_details_entity.dart';


abstract class ProductDetailsStates {}

class ProductDetailsInitialState extends ProductDetailsStates {}

class ProductDetailsLoadingState extends ProductDetailsStates {}

class ProductDetailsSuccessState extends ProductDetailsStates {
  final ProductDetailsEntity product;
  ProductDetailsSuccessState(this.product);
}

class ProductDetailsErrorState extends ProductDetailsStates {
  final String errorMessage;
  ProductDetailsErrorState(this.errorMessage);
}