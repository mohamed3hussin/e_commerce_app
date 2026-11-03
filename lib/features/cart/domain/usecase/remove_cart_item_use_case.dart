import '../repository/cart_repository.dart';

class RemoveCartItemUseCase {
  final CartRepository repository;

  RemoveCartItemUseCase({required this.repository});

  Future<void> call(int productId) {
    return repository.removeItem(productId);
  }
}