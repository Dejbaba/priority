import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/core/utilities/utilities.dart';
import 'package:priority_test/ui/pages/cart.dart';
import 'package:priority_test/ui/widgets/quantity_selector_and_price_preview.dart';



///add to cart bottom sheet
addToCartSuccessfulBottomSheet({
  required BuildContext context,
  required int selectedQuantity,
}){

  showModalBottomSheet(
      isScrollControlled: false,
      enableDrag: true,
      isDismissible: true,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: Container(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h,),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r)
                )
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/icons/add_to_cart_successful.svg",
                        width: 100.w,
                        height: 100.h,
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Added to cart',
                        style: GoogleFonts.urbanist(
                            color: ColorPath.codGrey,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '$selectedQuantity ${selectedQuantity > 1 ? 'Items':'Item'} Total',
                        style: GoogleFonts.urbanist(
                            color: ColorPath.doveGrey,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              ///nav user to discover screen
                              popUntilNavigation(context: context, route: '/');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                              elevation: 0,
                              side: BorderSide(color: ColorPath.mercuryGrey),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                            ),
                            child: Text('BACK EXPLORE', style: GoogleFonts.urbanist(
                                color: ColorPath.codGrey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700
                            ),), // Button's label
                          ),
                        ),
                        SizedBox(width: 15.w,),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              popNavigation(context: context);
                              ///nav users to cart
                              pushNavigation(context: context, widget: Cart());
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 45.w),
                              elevation: 0,
                              backgroundColor: ColorPath.codGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                            ),
                            child: Text('TO CART', style: GoogleFonts.urbanist(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700
                            ),), // Button's label
                          ),
                        ),
                      ],
                    )



                  ],
                ),
              ),
            ),
          ),
        );
      }).whenComplete(() {
  });
}