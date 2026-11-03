import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../models/cart_item_model.dart';
import 'cart_local_data_source.dart';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartItemModel> cartBox;

  CartLocalDataSourceImpl(this.cartBox);

  @override
  Future<void> addItem(CartItemModel item) async {
    final existingItem = cartBox.get(item.productId);

    if (existingItem != null) {
      final updatedItem = CartItemModel(
        productId: existingItem.productId,
        title: existingItem.title,
        price: existingItem.price,
        discountPercentage: existingItem.discountPercentage,
        thumbnail: existingItem.thumbnail,
        quantity: existingItem.quantity + item.quantity,
      );

      await cartBox.put(item.productId, updatedItem);
    } else {
      await cartBox.put(item.productId, item);
    }
  }

  @override
  Future<void> clearCart() async{
    await cartBox.clear();
  }

  @override
  List<CartItemModel> getCartItems() {
    return cartBox.values.toList();
  }

  @override
  Future<void> removeItem(int productId)async {
    await cartBox.delete(productId);
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async{
    final item = cartBox.get(productId);

    if (item != null) {
      if (quantity <= 0) {
        await cartBox.delete(productId);
      } else {
        final updatedItem = CartItemModel(
          productId: item.productId,
          title: item.title,
          price: item.price,
          discountPercentage: item.discountPercentage,
          thumbnail: item.thumbnail,
          quantity: quantity,
        );

        await cartBox.put(productId, updatedItem);
      }
    }
  }


}