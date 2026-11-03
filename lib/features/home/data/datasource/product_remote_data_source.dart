import 'package:e_commerce_app/features/home/data/model/category_model.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<CategoryModel>> getCategories();
}