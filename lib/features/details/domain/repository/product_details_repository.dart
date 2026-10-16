import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/product_details_entity.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(int productId);
}