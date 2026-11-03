import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/features/home/domain/entity/category_entity.dart';
import 'package:e_commerce_app/features/home/domain/repositories/product_repository.dart';

class GetCategoriesUseCase {
  final ProductRepository repository;

  GetCategoriesUseCase({required this.repository});
  Future<Either<Failure,List<CategoryEntity>>> call(){
    return repository.getCategories();
  }
}