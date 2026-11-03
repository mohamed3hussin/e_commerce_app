

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repository/cart_repository.dart';
import '../datasource/cart_local_data_source.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  CartItemEntity _toEntity(CartItemModel model) {
    return CartItemEntity(
      productId: model.productId,
      title: model.title,
      price: model.price,
      discountPercentage: model.discountPercentage,
      thumbnail: model.thumbnail,
      quantity: model.quantity,
    );
  }

  CartItemModel _toModel(CartItemEntity entity) {
    return CartItemModel(
      productId: entity.productId,
      title: entity.title,
      price: entity.price,
      discountPercentage: entity.discountPercentage,
      thumbnail: entity.thumbnail,
      quantity: entity.quantity,
    );
  }

  @override
  List<CartItemEntity> getCartItems() {
    return localDataSource
        .getCartItems()
        .map(_toEntity)
        .toList();
  }

  @override
  Future<void> addItem(CartItemEntity item) async {
    await localDataSource.addItem(_toModel(item));
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    await localDataSource.updateQuantity(productId, quantity);
  }

  @override
  Future<void> removeItem(int productId) async {
    await localDataSource.removeItem(productId);
  }

  @override
  Future<void> clearCart() async {
    await localDataSource.clearCart();
  }
}
