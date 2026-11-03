import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/dependency_injection/injection_container.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../widget/cart_item_widget.dart';
import '../widget/order_summary_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: BlocBuilder<CartCubit,CartState>(
          builder: (context,state){
            if(state is CartLoaded){
              if(state.items.isEmpty){
                return Center(
                  child: Text('No Items yet!'),
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context,index){
                          final item = state.items[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Dismissible(
                              key: ValueKey(item.productId),

                              direction: DismissDirection.endToStart,

                              background: Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),

                              confirmDismiss: (_) async {
                                return await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("Remove Product"),
                                    content: Text(
                                      "Remove ${item.title} from cart?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  ),
                                ) ??
                                    false;
                              },

                              onDismissed: (_) {
                                final removedItem = item;

                                final cartCubit = context.read<CartCubit>();

                                cartCubit.removeItem(removedItem.productId);

                              },

                              child: CartItemWidget(
                                item: item,
                              ),
                            ),
                          );
                        },

                        itemCount: state.items.length,
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OrderSummaryWidget(total: state.totalPrice,),
                        SizedBox(height: 16.h,),
                        SizedBox(
                          width: double.infinity,
                          height: 54.h,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // context.read<CartCubit>().addProduct(product, quantity);
                            },
                            icon: const Icon(Icons.shopping_cart_outlined),
                            label: Text(
                              'Proceed',
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
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            if(state is CartLoading){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is CartError){
              return Center(
                child: Text(state.message),
              );
            }
            return SizedBox();
          }
      ),
    );
  }
}
