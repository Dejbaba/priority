import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/core/utilities/utilities.dart';
import 'package:priority_test/core/view_models/cart_view_model.dart';
import 'package:priority_test/core/view_models/order_view_model.dart';
import 'package:priority_test/ui/widgets/custom_appbar.dart';
import 'package:priority_test/ui/widgets/dock.dart';
import 'package:priority_test/ui/widgets/floating_flush_bar.dart';
import 'package:priority_test/ui/widgets/listview_items/order_summary_item.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Order Summary',
      ),
      body: Consumer(
        builder: (context, ref, child){
          final _cartVm = ref.watch(cartVm);
          final _orderVm = ref.watch(orderVm);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h, bottom: 60.h),
                  children: [
                    ///order information
                    information(context: context),
                    SizedBox(height: 30.h,),
                    orderDetails(context: context, cartVm: _cartVm),
                    SizedBox(height: 30.h,),
                    paymentDetails(context: context, cartVm: _cartVm)

                  ],
                ),
              ),
              Dock(
                amount: _cartVm.subTotalPrice + 20,
                buttonHorizontalPadding: 46.5,
                buttonText: 'PAYMENT',
                label: 'Grand Total',
                onPressed: ()async{
                  await _orderVm.createOrder(cartVm: _cartVm);
                  if(_orderVm.state == ViewState.Retrieved){
                    popUntilNavigation(context: context, route: '/');
                    ///display success prompt to user
                    showFloatingFlushBar(
                      context: context,
                      bgColor: Colors.green,
                      message: "Order Created successfully",
                      duration: 2,
                      messageColor: Colors.white,
                    );
                  }
                  else{
                    ///display error message
                    showFloatingFlushBar(
                      context: context,
                      message: "An error occurred",
                      duration: 2,
                      messageColor: Colors.white,
                    );
                  }

                },
              )
            ],
          );
        }
      ),
    );
  }

  ///order information
  information({required BuildContext context}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Information',
        style: GoogleFonts.urbanist(
            color: ColorPath.codGrey,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700
        ),
      ),
      SizedBox(height: 20.h,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Method',
                style: GoogleFonts.urbanist(
                    color: ColorPath.codGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 5.h,),
              Text(
                'Credit Card',
                style: GoogleFonts.urbanist(
                    color: ColorPath.doveGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            "assets/icons/arrow_right.svg",
            width: 16.w,
            height: 16.h,
          ),
        ],
      ),
      Container(
        height: 1.h,
        width: double.infinity,
        color: ColorPath.concreteGrey,
        margin: EdgeInsets.symmetric(vertical: 20.h),

      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location',
                style: GoogleFonts.urbanist(
                    color: ColorPath.codGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 5.h,),
              Text(
                'Semarang, Indonesia',
                style: GoogleFonts.urbanist(
                    color: ColorPath.doveGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            "assets/icons/arrow_right.svg",
            width: 16.w,
            height: 16.h,
          ),
        ],
      ),
    ],
  );

  ///order details
  orderDetails({required BuildContext context, required CartViewModel cartVm}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Detail',
          style: GoogleFonts.urbanist(
              color: ColorPath.codGrey,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(height: 20.h,),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemCount: cartVm.cartProducts.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final _orderItem = cartVm.cartProducts[index];
            return OrderSummaryItem(orderDetail: _orderItem,);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 20.h,);
          },
        )
      ],
    );
  }

  ///payment details
  paymentDetails({required BuildContext context, required CartViewModel cartVm}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Detail',
          style: GoogleFonts.urbanist(
              color: ColorPath.codGrey,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(height: 20.h,),
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
              '\$${Utilities.formatAmount(amount: cartVm.subTotalPrice)}',
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
              '\$${Utilities.formatAmount(amount: double.tryParse('20'))}',
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
          color: ColorPath.concreteGrey,
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
              '\$${Utilities.formatAmount(amount: cartVm.subTotalPrice + 20)}',
              style: GoogleFonts.urbanist(
                  color: ColorPath.codGrey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
      ],
    );
  }
}
