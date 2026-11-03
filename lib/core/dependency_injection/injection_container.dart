import 'package:dio/dio.dart';
import 'package:e_commerce_app/features/cart/data/repository/cart_repository_impl.dart';
import 'package:e_commerce_app/features/cart/domain/repository/cart_repository.dart';
import 'package:e_commerce_app/features/cart/domain/usecase/add_cart_item_use_case.dart';
import 'package:e_commerce_app/features/cart/domain/usecase/clear_cart_use_case.dart';
import 'package:e_commerce_app/features/cart/domain/usecase/get_cart_items_use_case.dart';
import 'package:e_commerce_app/features/cart/domain/usecase/remove_cart_item_use_case.dart';
import 'package:e_commerce_app/features/cart/domain/usecase/update_cart_quantity_use_case.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/home/data/datasource/product_remote_data_source.dart';
import 'package:e_commerce_app/features/home/data/datasource/product_remote_data_source_impl.dart';
import 'package:e_commerce_app/features/home/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/home/domain/repositories/product_repository.dart';
import 'package:e_commerce_app/features/home/domain/usecase/get_categories_use_case.dart';
import 'package:e_commerce_app/features/home/domain/usecase/get_products_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/cart/data/datasource/cart_local_data_source.dart';
import '../../features/cart/data/datasource/cart_local_data_source_impl.dart';
import '../../features/cart/data/models/cart_item_model.dart';
import '../../features/home/presentation/cubit/product_cubit.dart';


final sl = GetIt.instance;

Future<void> setupDependencies()async{
  sl.registerLazySingleton<Dio>(
        () => Dio(),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl())
  );
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remoteDataSource: sl())
  );
  sl.registerLazySingleton(
      () => GetProductsUseCase(repository: sl())
  );
  sl.registerLazySingleton(
      () => GetCategoriesUseCase(repository: sl())
  );
  sl.registerFactory(
        () => ProductCubit(getProductsUseCase: sl(),getCategoriesUseCase: sl()),
  );

  sl.registerLazySingleton<Box<CartItemModel>>(
        () => Hive.box<CartItemModel>('cartBox'),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
        () => CartLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CartRepository>(
        () => CartRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton(
        () => GetCartItemsUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
        () => AddCartItemUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
        () => UpdateCartQuantityUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
        () => RemoveCartItemUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
        () => ClearCartUseCase(repository: sl()),
  );
  sl.registerFactory(
      () => CartCubit(
          getCartItemsUseCase: sl(),
          addCartItemUseCase: sl(),
          updateCartQuantityUseCase: sl(),
          removeCartItemUseCase: sl(),
          clearCartUseCase: sl(),
      )
  );
}