import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/usecase/add_cart_item_use_case.dart';
import '../../domain/usecase/clear_cart_use_case.dart';
import '../../domain/usecase/get_cart_items_use_case.dart';
import '../../domain/usecase/remove_cart_item_use_case.dart';
import '../../domain/usecase/update_cart_quantity_use_case.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItemsUseCase getCartItemsUseCase;
  final AddCartItemUseCase addCartItemUseCase;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;
  final RemoveCartItemUseCase removeCartItemUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartCubit({
    required this.getCartItemsUseCase,
    required this.addCartItemUseCase,
    required this.updateCartQuantityUseCase,
    required this.removeCartItemUseCase,
    required this.clearCartUseCase,
  }) : super(CartInitial());

  void loadCart() {
    try {
      emit(CartLoaded(getCartItemsUseCase()));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addItem(CartItemEntity item) async {
    try {
      await addCartItemUseCase(item);
      loadCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    try {
      await updateCartQuantityUseCase(productId, quantity);
      loadCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> removeItem(int productId) async {
    try {
      await removeCartItemUseCase(productId);
      loadCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> clearCart() async {
    try {
      await clearCartUseCase();
      loadCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}