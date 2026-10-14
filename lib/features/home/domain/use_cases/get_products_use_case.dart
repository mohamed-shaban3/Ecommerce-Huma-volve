import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/Failure/Failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';

class GetProductsUseCase {
  final HomeRepository homeRepository;

  GetProductsUseCase(this.homeRepository);

  Future<Either<Failure, List<HomeProductEntity>>> invoke(int? categoryId) {
    return homeRepository.getProducts(categoryId);
  }
}