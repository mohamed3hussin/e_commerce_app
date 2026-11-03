
import '../../domain/entities/cart_item_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> items;

  CartLoaded(this.items);

  double get totalPrice => items.fold(
    0,
        (sum, item) => sum + item.totalPrice,
  );

  int get totalQuantity => items.fold(
    0,
        (sum, item) => sum + item.quantity,
  );
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}