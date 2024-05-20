import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/core/view_models/cart_view_model.dart';
import 'package:priority_test/core/view_models/wishlist_view_model.dart';
import 'package:priority_test/ui/pages/cart.dart';
import 'package:priority_test/ui/pages/wishlist.dart';

class WishListIcon extends StatelessWidget {
  const WishListIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushNavigation(context: context, widget: Wishlist());
      },
      child: Consumer(
          builder: (context, ref, child){
            final _wishlistVm = ref.watch(wishlistVm);
            if(_wishlistVm.isWishlistNotEmpty){
              ///display wishlist icon when wishlist isn't empty
              return ElasticIn(
                key: Key('cart'),
                duration: Duration(seconds: 1),
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: SvgPicture.asset(
                    "assets/icons/wishlist_added.svg",
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              );
            }
            return Container();


          }
      ),
    );
  }
}
