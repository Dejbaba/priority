import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/models/order.dart';
import 'package:priority_test/core/utilities/utilities.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 13.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Id:',
                style: GoogleFonts.urbanist(
                    color: ColorPath.codGrey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600
                ),
              ),
              FittedBox(
                child: Text(
                  '${order.id}',
                  style: GoogleFonts.urbanist(
                      color: ColorPath.nobelGrey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date Created:',
                style: GoogleFonts.urbanist(
                    color: ColorPath.codGrey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600
                ),
              ),
              Text(
                '${Utilities.actualDay(order.createdDate!)}',
                style: GoogleFonts.urbanist(
                    color: ColorPath.nobelGrey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(height: 15.h,),
          Container(
            height: 1.h,
            color: ColorPath.codGrey,
            margin: EdgeInsets.symmetric(vertical: 15.h),
          ),
          Text(
            'Order Detail',
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 20.h,),
          Column(
            children: List.generate(order.orderDetail!.length, (index) => Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0:10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${order.orderDetail![index].productName}',
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
                          '${order.orderDetail![index].brandName} . ${order.orderDetail![index].color} . ${order.orderDetail![index].size} . Qty ${order.orderDetail![index].quantity}',
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
                      '\$${Utilities.formatAmount(amount: double.tryParse('${order.orderDetail![index].price?.toString()}')! * order.orderDetail![index].quantity!)}',
                      style: GoogleFonts.urbanist(
                          color: ColorPath.codGrey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ),
          SizedBox(height: 15.h,),
          Text(
            'Payment Detail',
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 20.h,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sub Total',
                    style: GoogleFonts.urbanist(
                        color: ColorPath.doveGrey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    '\$${Utilities.formatAmount(amount: double.parse('${order.paymentDetail!.subTotal?.toString()}'))}',
                    style: GoogleFonts.urbanist(
                        color: ColorPath.codGrey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
              SizedBox(height: 21.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping',
                    style: GoogleFonts.urbanist(
                        color: ColorPath.doveGrey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    '\$${Utilities.formatAmount(amount: double.tryParse('${order.paymentDetail!.shipping?.toString()}'))}',
                    style: GoogleFonts.urbanist(
                        color: ColorPath.codGrey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
              Container(
                height: 1.h,
                width: double.infinity,
                color: ColorPath.codGrey,
                margin: EdgeInsets.symmetric(vertical: 20.h),

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Order',
                    style: GoogleFonts.urbanist(
                        color: ColorPath.doveGrey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    '\$${Utilities.formatAmount(amount: double.parse('${order.paymentDetail!.total?.toString()}'))}',
                    style: GoogleFonts.urbanist(
                        color: ColorPath.codGrey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ],
              ),
            ],
          )




        ],
      ),
    );
  }
}
