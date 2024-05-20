import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/models/cart_product.dart';
import 'package:priority_test/core/utilities/utilities.dart';

class OrderSummaryItem extends StatelessWidget {
  final CartProduct orderDetail;
  const OrderSummaryItem({super.key, required this.orderDetail});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${orderDetail.productName}',
                style: GoogleFonts.urbanist(
                    color: ColorPath.codGrey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10.h),
              Text(
                '${orderDetail.brandName} . ${orderDetail.color} . ${orderDetail.size} . Qty ${orderDetail.quantity}',
                style: GoogleFonts.urbanist(
                    color: ColorPath.doveGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        FittedBox(
          child: Text(
            '\$${Utilities.formatAmount(amount: double.tryParse('${orderDetail.price.toString()}'))}',
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700
            ),
          ),
        ),
      ],
    );
  }
}
