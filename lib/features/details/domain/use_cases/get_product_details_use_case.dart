import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/product_details_entity.dart';
import '../repository/product_details_repository.dart';

class GetProductDetailsUseCase {
  final ProductDetailsRepository repository;

  GetProductDetailsUseCase(this.repository);

  Future<Either<Failure, ProductDetailsEntity>> invoke(int productId) async {
    return await repository.getProductDetails(productId);
  }
}