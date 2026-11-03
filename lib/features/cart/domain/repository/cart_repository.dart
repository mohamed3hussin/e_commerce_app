import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  List<CartItemEntity> getCartItems();

  Future<void> addItem(CartItemEntity item);

  Future<void> updateQuantity(int productId, int quantity);

  Future<void> removeItem(int productId);

  Future<void> clearCart();
}
