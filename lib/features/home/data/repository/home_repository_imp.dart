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
      return Right(categories as List<HomeCategoryEntity>);
    } catch (e) {
      return Left(ErrorHandler.handle(e) as Failure);
    }
  }

  @override
  Future<Either<Failure, List<HomeProductEntity>>> getProducts(
    int? categoryId,
  ) async {
    try {
      final products = await homeRemoteDataSource.getProducts(categoryId);
      return Right(products as List<HomeProductEntity>);
    } catch (e) {
      return Left(ErrorHandler.handle(e) as Failure);
    }
  }
}
