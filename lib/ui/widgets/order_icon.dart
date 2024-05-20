import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/core/view_models/cart_view_model.dart';
import 'package:priority_test/core/view_models/order_view_model.dart';
import 'package:priority_test/core/view_models/wishlist_view_model.dart';
import 'package:priority_test/ui/pages/cart.dart';
import 'package:priority_test/ui/pages/orders.dart';
import 'package:priority_test/ui/pages/wishlist.dart';

class OrderIcon extends StatelessWidget {
  const OrderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushNavigation(context: context, widget: Orders());
      },
      child: ElasticIn(
        key: Key('cart'),
        duration: Duration(seconds: 1),
        child: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: SvgPicture.asset(
            "assets/icons/order.svg",
            width: 24.w,
            height: 24.h,
          ),
        ),
      ),
    );
  }
}
