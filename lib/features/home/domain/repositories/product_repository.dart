import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/features/home/domain/entity/category_entity.dart';
import 'package:e_commerce_app/features/home/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure,List<ProductEntity>>> getProducts();
  Future<Either<Failure,List<CategoryEntity>>> getCategories();
}