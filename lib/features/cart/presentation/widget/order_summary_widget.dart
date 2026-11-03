import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    super.key,
    required this.total,
  });

  final double total;

  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          children: [

            _buildRow(
              title: 'Subtotal',
              value: '${total.toStringAsFixed(2)} EGP',
            ),

            SizedBox(height: 12.h),

            _buildRow(
              title: 'Delivery',
              value: 'Free',
            ),

            Divider(height: 30.h),

            _buildRow(
              title: 'Total',
              value: '${total.toStringAsFixed(2)} EGP',
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow({
    required String title,
    required String value,
    bool isBold = false,
  }) {
    return Row(
      children: [

        Text(
          title,
          style: isBold
              ? TextStyle(fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          color: Colors.black)
              : TextStyle(fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        ),

        const Spacer(),

        Text(
          value,
          style: isBold
              ? TextStyle(fontSize: 18.sp,
            fontWeight: FontWeight.w600,color: Colors.blue)
              : TextStyle(fontSize: 16.sp,
            fontWeight: FontWeight.w400,color: Colors.black),
        ),
      ],
    );
  }
}