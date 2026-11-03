
import 'package:e_commerce_app/features/cart/data/models/cart_item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../dependency_injection/injection_container.dart';

class AppInitializer {
  static Future<void>init()async{

    await Hive.initFlutter();
    Hive.registerAdapter(CartItemModelAdapter());
    await Hive.openBox<CartItemModel>('cartBox');
    await setupDependencies();
  }
}