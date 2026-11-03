import 'package:e_commerce_app/features/home/domain/entity/product_entity.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/home_icon_button.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/quantity_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/dependency_injection/injection_container.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key,required this.product,required this.discountedPrice});
  final ProductEntity product;
  final double discountedPrice;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedQuantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 380.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  image: DecorationImage(
                    image: NetworkImage(widget.product.images.first),
                    fit: BoxFit.cover,

                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50.h,
                left: 10.h,
                  child: HomeIconButton(
                      icon: Icons.arrow_back_ios_new,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      color: Colors.black,
                  ))
            ],
          ),
          SizedBox(height: 8.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 8.h,),
                Row(
                  children: [
                    Icon(Icons.star_rounded,size: 18.sp,color: Colors.amber,),
                    SizedBox(width: 2.w,),
                    Text(
                      widget.product.rating.toStringAsFixed(1),
                      style: TextStyle(color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 10.w,),
                    Text(
                      '${widget.product.reviews.length} reviews',
                      style: TextStyle(color: Colors.grey[600],fontSize: 14.sp,),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                      decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_shipping_outlined,size: 18.sp,),
                          SizedBox(width: 4.w,),
                          Text(
                            'Free Shipping',
                            style: TextStyle(
                                color: Colors.greenAccent.shade700,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h,),
                Row(
                  children: [
                    if(widget.discountedPrice < widget.product.price)
                      Text(
                        '${widget.discountedPrice.toStringAsFixed(2)} \$',
                        style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,color: Colors.black),
                      ),
                    SizedBox(width: 8.w,),
                    Text(
                      '${widget.product.price.toStringAsFixed(2)} \$',
                      style: TextStyle(
                          fontSize:widget.discountedPrice < widget.product.price ?14.sp : 20.sp,
                          fontWeight:widget.discountedPrice < widget.product.price? null : FontWeight.w600,
                          color:widget.discountedPrice < widget.product.price ? Colors.grey[600] : Colors.black,
                          decoration:widget.discountedPrice < widget.product.price ? TextDecoration.lineThrough : null
                      ),
                    ),
                    SizedBox(width: 12.w,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r)
                      ),
                      child: Text(
                        '${widget.product.discountPercentage.toStringAsFixed(0)}% OFF',
                        style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h,),
                Text(
                  widget.product.description,
                  maxLines: 4,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp
                  ),
                ),
                SizedBox(height: 16.h,),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Quantity',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    QuantitySelector(
                      onChanged: (quantity) {
                        selectedQuantity = quantity;
                      },
                    ),
                  ],
                ),
                SizedBox(height: 32.h,),
                SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final cartItem = CartItemEntity(
                        productId: widget.product.id,
                        title: widget.product.title,
                        price: widget.product.price,
                        discountPercentage: widget.product.discountPercentage,
                        thumbnail: widget.product.thumbnail,
                        quantity: selectedQuantity,
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
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
