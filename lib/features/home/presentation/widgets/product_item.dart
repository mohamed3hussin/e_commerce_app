import 'package:e_commerce_app/features/home/presentation/widgets/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../domain/entity/product_entity.dart';
import 'home_icon_button.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product
  });
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final discountedPrice = product.price *(1-product.discountPercentage/100);
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: product,discountedPrice: discountedPrice,),
          ),
        );
      },
      child: Container(
        width: 200.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120.h,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(18.r),
                ),
                child: Image.network(
                  product.images.first,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.broken_image_rounded,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black,fontSize: 16.sp,fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4.h,),
                    Text(product.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Colors.grey),
                    ),
                    SizedBox(height: 6.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(discountedPrice < product.price)
                              Text(
                                '${discountedPrice.toStringAsFixed(2)} \$',
                                style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,color: Colors.black),
                              ),

                            Text(
                              '${product.price.toStringAsFixed(2)} \$',
                              style: TextStyle(
                                  fontSize:discountedPrice < product.price ?14.sp : 20.sp,
                                  fontWeight:discountedPrice < product.price? null : FontWeight.w600,
                                  color:discountedPrice < product.price ? Colors.grey : Colors.black,
                                  decoration:discountedPrice < product.price ? TextDecoration.lineThrough : null
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        HomeIconButton(
                          icon: Icons.add,
                          onPressed: () async {
                            final cartItem = CartItemEntity(
                              productId: product.id,
                              title: product.title,
                              price: product.price,
                              discountPercentage: product.discountPercentage,
                              thumbnail: product.thumbnail,
                              quantity: 1,
                            );

                            await context.read<CartCubit>().addItem(cartItem);

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Product added to cart'),
                                ),
                              );
                            }
                          },
                          color: Colors.blue,
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
