import 'package:e_commerce_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/categories_section.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/home_icon_button.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/home_searsh_bar.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/products_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../cart/presentation/cubit/cart_state.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,

  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String searchQuery = '';
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce',style: TextStyle(fontWeight: FontWeight.w600),),
        centerTitle: true,

        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final count = state is CartLoaded ? state.items.length : 0;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  HomeIconButton(
                    icon: Icons.shopping_cart,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                    color: Colors.blue,
                  ),
                  if (count > 0)
                    Positioned(
                      top: -5,
                      right: -5,
                      child: IgnorePointer(
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          constraints: BoxConstraints(
                            minWidth: 20.r,
                            minHeight: 20.r,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            count > 99 ? '99+' : '$count',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          SizedBox(width: 10.h),
        ],

      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProductError) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is ProductSuccess) {
            if (state.products.isEmpty) {
              return const Center(
                child: Text('No products found'),
              );
            }

            final query = searchQuery.trim().toLowerCase();

            final filteredProducts = state.products.where((product) {
              final matchesSearch =
                  product.title.toLowerCase().contains(query) ||
                      product.description.toLowerCase().contains(query);

              final matchesCategory = selectedCategory == null ||
                  product.category == selectedCategory;

              return matchesSearch && matchesCategory;
            }).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                child: Column(
                  children: [
                    HomeSearchBar(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.h,),
                    CategoriesSection(
                      categories: state.categories,
                      selectedCategory: selectedCategory,
                      onCategorySelected: (category) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                    filteredProducts.isEmpty
                        ? const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: Text('No matching products found'),
                      ),
                    )
                        : ProductsSection(products: filteredProducts),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
