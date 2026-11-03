import '../repository/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository repository;

  ClearCartUseCase({required this.repository});

  Future<void> call() {
    return repository.clearCart();
  }
}