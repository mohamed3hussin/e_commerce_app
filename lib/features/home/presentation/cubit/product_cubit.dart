import 'package:e_commerce_app/features/home/domain/usecase/get_categories_use_case.dart';
import 'package:e_commerce_app/features/home/domain/usecase/get_products_use_case.dart';
import 'package:e_commerce_app/features/home/presentation/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  ProductCubit({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase}):super(const ProductInitial());

  Future<void> getProducts()async{
    emit(ProductLoading());
    final categoriesResult = await getCategoriesUseCase();
    final productsResult = await getProductsUseCase();
    categoriesResult.fold(
      (failure){
        emit(ProductError(failure.message));
      },
      (categories){
        productsResult.fold(
              (failure){
            emit(ProductError(failure.message));
          },
          (products){
                emit(ProductSuccess(products: products, categories: categories));
          },
        );
      },
    );
  }
}