
import 'package:e_commerce_app/features/home/domain/entity/category_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/features/home/domain/entity/product_entity.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductSuccess extends ProductState {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;

  const ProductSuccess({required this.products, required this.categories});



  @override
  List<Object?> get props => [products,categories];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
