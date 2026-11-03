import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/features/home/data/datasource/product_remote_data_source.dart';
import 'package:e_commerce_app/features/home/domain/entity/category_entity.dart';
import 'package:e_commerce_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_app/features/home/domain/repositories/product_repository.dart';

import '../../../../core/errors/exceptions.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async{
    try{
      final products = await remoteDataSource.getProducts();
      return Right(products.map<ProductEntity>((product) => product).toList());
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }catch(e){
      return Left(ServerFailure(message: "something went wrong"));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async{
    try{
      final categories = await remoteDataSource.getCategories();
      return Right(categories.map<CategoryEntity>((category) => category).toList());
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }catch(e){
      return Left(ServerFailure(message: "something went wrong"));
    }
  }
}