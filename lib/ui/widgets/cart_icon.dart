import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/core/view_models/cart_view_model.dart';
import 'package:priority_test/ui/pages/cart.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushNavigation(context: context, widget: Cart());
      },
      child: Consumer(
        builder: (context, ref, child){
          final _cartVm = ref.watch(cartVm);
          if(_cartVm.isCartEmpty){
            return SvgPicture.asset(
              "assets/icons/cart_empty.svg",
              width: 24.w,
              height: 24.h,
            );
          }
          return ElasticIn(
            key: Key('cart'),
            duration: Duration(seconds: 1),
            child: SvgPicture.asset(
              "assets/icons/cart.svg",
              width: 24.w,
              height: 24.h,
            ),
          );

        }
      ),
    );
  }
}
