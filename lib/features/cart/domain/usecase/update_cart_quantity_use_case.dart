import '../repository/cart_repository.dart';

class UpdateCartQuantityUseCase {
  final CartRepository repository;

  UpdateCartQuantityUseCase({required this.repository});

  Future<void> call(int productId, int quantity) {
    return repository.updateQuantity(productId, quantity);
  }
}