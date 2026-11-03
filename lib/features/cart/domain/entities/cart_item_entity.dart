
import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final int productId;
  final String title;
  final double price;
  final double discountPercentage;
  final String thumbnail;
  final int quantity;

  const CartItemEntity({
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

  @override
  List<Object?> get props => [
    productId,
    title,
    price,
    discountPercentage,
    thumbnail,
    quantity,
  ];
}
