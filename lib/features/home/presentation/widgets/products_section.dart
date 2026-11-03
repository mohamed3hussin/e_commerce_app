import 'package:e_commerce_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key,required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Products',
          style: TextStyle(
            fontSize:  20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),),
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context,index){
              final product = products[index];
              return ProductItem(product: product);
            },
        ),
      ],
    );
  }
}
