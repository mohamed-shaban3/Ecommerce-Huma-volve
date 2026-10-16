import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/Failure/Failure.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handling.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImp({required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, List<HomeCategoryEntity>>> getCategories() async {
    try {
      final categories = await homeRemoteDataSource.getCategories();
      return Right(categories.cast<HomeCategoryEntity>());
    } catch (e) {
      return Left(ErrorHandler.handle(e) as Failure);
    }
  }

@override
  Future<Either<Failure, List<HomeProductEntity>>> getProducts(
    int? categoryId, {
    required int limit,
    required int offset,
  }) async {
    try {
      final products = await homeRemoteDataSource.getProducts(
        categoryId,
        limit: limit,
        offset: offset,
      );
      return Right(products.cast<HomeProductEntity>());
    } catch (e, stackTrace) {
      print("===== GET PRODUCTS ERROR =====");
      print(e);
      print(stackTrace);
      return Left(ErrorHandler.handle(e) as Failure);
    }
  }
}
