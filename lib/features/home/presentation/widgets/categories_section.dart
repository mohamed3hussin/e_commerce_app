import 'package:e_commerce_app/features/home/domain/entity/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'category_item.dart';


class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    required this.selectedCategory,
  });
  final List<CategoryEntity> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;
  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> categoryIcons = {
      'beauty': Icons.face_retouching_natural,
      'fragrances': Icons.spa_outlined,
      'furniture': Icons.chair_outlined,
      'groceries': Icons.shopping_basket_outlined,
      'home-decoration': Icons.home_outlined,
      'kitchen-accessories': Icons.kitchen_outlined,
      'laptops': Icons.laptop_outlined,
      'mens-shirts': Icons.checkroom_outlined,
      'mens-shoes': Icons.shopping_bag_outlined,
      'mens-watches': Icons.watch_outlined,
      'mobile-accessories': Icons.phone_android,
      'motorcycle': Icons.two_wheeler_outlined,
      'skin-care': Icons.spa_outlined,
      'smartphones': Icons.smartphone,
      'sports-accessories': Icons.sports_basketball_outlined,
      'sunglasses': Icons.wb_sunny_outlined,
      'tablets': Icons.tablet_outlined,
      'tops': Icons.checkroom_outlined,
      'vehicle': Icons.directions_car_outlined,
      'womens-bags': Icons.shopping_bag_outlined,
      'womens-dresses': Icons.dry_cleaning_outlined,
      'womens-jewellery': Icons.diamond_outlined,
      'womens-shoes': Icons.shopping_bag_outlined,
      'womens-watches': Icons.watch_outlined,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'categories',
          style: TextStyle(
            fontSize:  20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),


        SizedBox(
          height: 100.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () => onCategorySelected(null),
                child: SizedBox(
                  width: 70.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedCategory == null
                              ? Colors.blue
                              : Colors.blue.withValues(alpha: 0.12),
                        ),
                        child: Icon(
                          Icons.apps,
                          color: selectedCategory == null
                              ? Colors.white
                              : Colors.blue,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'All',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: selectedCategory == null
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ...categories.map((category) {
                final icon = categoryIcons[category.slug] ??
                    Icons.category_outlined;

                return CategoryItem(
                  category: category,
                  icon: icon,
                  isSelected: selectedCategory == category.slug,
                  onTap: () => onCategorySelected(category.slug),
                );
              }),
            ],
          ),
        ),

      ],
    );
  }
}
