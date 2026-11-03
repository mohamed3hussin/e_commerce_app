
import '../entities/cart_item_entity.dart';
import '../repository/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository repository;

  GetCartItemsUseCase({required this.repository});

  List<CartItemEntity> call() {
    return repository.getCartItems();
  }
}
