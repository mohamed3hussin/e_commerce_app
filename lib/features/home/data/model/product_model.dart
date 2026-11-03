import 'package:e_commerce_app/features/home/data/model/review_model.dart';
import 'package:e_commerce_app/features/home/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.category,
    required super.thumbnail,
    required super.images,
    super.brand,
    required super.reviews
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      discountPercentage:
      (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'] as int,
      brand: json['brand'] as String?,
      category: json['category'] as String,
      thumbnail: json['thumbnail'] as String,
      images: List<String>.from(json['images'] as List),
      reviews: (json['reviews'] as List).map(
          (review) => ReviewModel.fromJson(review as Map<String,dynamic>),
      ).toList(),
    );
  }


}