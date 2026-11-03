
import 'package:e_commerce_app/features/home/domain/entity/review_entity.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String? brand;
  final String category;
  final String thumbnail;
  final List<String> images;
  final List<ReviewEntity> reviews;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    required this.reviews,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
    description,
    price,
    discountPercentage,
    rating,
    stock,
    brand,
    category,
    thumbnail,
    images,
    reviews,
  ];
}
