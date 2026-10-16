import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart'; // تأكد أنها failure بحروف صغيرة تماماً مثل الـ Interface
import '../../../../core/error/error_handling.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/repository/product_details_repository.dart';
import '../data_source/product_details_remote_data_source.dart';

class ProductDetailsRepositoryImp implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource remoteDataSource;

  ProductDetailsRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(int productId) async {
    try {
      final productModel = await remoteDataSource.getProductDetails(productId);
      return Right(productModel);
    } catch (e) {
      return Left(ErrorHandler.handle(e) as Failure);
    }
  }
}