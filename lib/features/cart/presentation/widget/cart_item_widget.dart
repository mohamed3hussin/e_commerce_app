import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../cubit/cart_cubit.dart';


class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.item
  });
  final CartItemEntity item;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.withOpacity(.08),
      elevation: 1.5,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(22.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    item.thumbnail,
                    width: 110.w,
                    height: 110.h,
                    fit: BoxFit.cover,
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
                SizedBox(width: 16.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title,
                        style: TextStyle(color: Colors.black,fontSize: 16.sp,fontWeight: FontWeight.w400),
                      ),

                      SizedBox(height: 12.h,),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '${item.discountedPrice.toStringAsFixed(2)} EGP',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (item.discountPercentage > 0) ...[
                            SizedBox(width: 8.w),
                            Flexible(
                              child: Text(
                                '${item.price.toStringAsFixed(2)} EGP',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (item.discountPercentage > 0)
                        Row(
                        children: [
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r)
                            ),
                            child: Text(
                              '${item.discountPercentage.toStringAsFixed(0)}% OFF',
                              style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              context.read<CartCubit>().updateQuantity(
                                item.productId,
                                item.quantity - 1,
                              );
                            },
                            icon: const Icon(Icons.remove,color: Colors.black,),
                          ),

                          Text(
                            item.quantity.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              context.read<CartCubit>().updateQuantity(
                                item.productId,
                                item.quantity + 1,
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
