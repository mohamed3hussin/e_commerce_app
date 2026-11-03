
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantitySelector extends StatefulWidget {
  final ValueChanged<int> onChanged;

  const QuantitySelector({
    super.key,
    required this.onChanged,
  });

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.r),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: quantity > 1
                ? () {
              setState(() {
                quantity--;
              });
              widget.onChanged(quantity);
            }
                : null,
            icon: const Icon(Icons.remove),
            iconSize: 18.sp,
            constraints: BoxConstraints(
              minWidth: 36.w,
              minHeight: 36.h,
            ),
            padding: EdgeInsets.zero,
          ),
          SizedBox(
            width: 32.w,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                quantity++;
              });
              widget.onChanged(quantity);
            },
            icon: const Icon(Icons.add),
            iconSize: 18.sp,
            constraints: BoxConstraints(
              minWidth: 36.w,
              minHeight: 36.h,
            ),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

