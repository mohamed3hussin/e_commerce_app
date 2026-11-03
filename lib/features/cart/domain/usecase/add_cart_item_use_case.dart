
import '../entities/cart_item_entity.dart';
import '../repository/cart_repository.dart';

class AddCartItemUseCase {
  final CartRepository repository;

  AddCartItemUseCase({required this.repository});

  Future<void> call(CartItemEntity item) {
    return repository.addItem(item);
  }
}
