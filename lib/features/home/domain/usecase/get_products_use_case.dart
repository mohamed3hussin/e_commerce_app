import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_app/features/home/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});
  Future<Either<Failure,List<ProductEntity>>> call(){
    return repository.getProducts();
  }
}