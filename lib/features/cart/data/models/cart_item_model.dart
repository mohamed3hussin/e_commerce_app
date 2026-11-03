
import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 3)
class CartItemModel {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final double discountPercentage;

  @HiveField(4)
  final String thumbnail;

  @HiveField(5)
  final int quantity;

  const CartItemModel({
    required this.productId,
    required this.title,
    required this.price,
    required this.discountPercentage,
    required this.thumbnail,
    required this.quantity,
  });

  double get discountedPrice =>
      price * (1 - discountPercentage / 100);

  double get totalPrice => discountedPrice * quantity;
}
