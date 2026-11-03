import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/features/home/data/datasource/product_remote_data_source.dart';
import 'package:e_commerce_app/features/home/data/model/category_model.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);
  @override
  Future<List<ProductModel>> getProducts() async{
    try{
      final response = await dio.get('https://dummyjson.com/products');
      final products = response.data['products'] as List;
      return products.map(
          (product) => ProductModel.fromJson(product as Map<String,dynamic>)
      ).toList();
    }on DioException catch(e){
      throw ServerException(message: e.message ??'something went wrong');
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async{
    try{
      final response = await dio.get('https://dummyjson.com/products/categories');
      final categories = response.data as List;
      return categories.map(
              (category) => CategoryModel.fromJson(category as Map<String,dynamic>)
      ).toList();
    }on DioException catch(e){
      throw ServerException(message: e.message ??'something went wrong');
    }
  }
}