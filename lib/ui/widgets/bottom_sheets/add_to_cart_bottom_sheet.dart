import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/ui/widgets/quantity_selector_and_price_preview.dart';



///add to cart bottom sheet
addToCartBottomSheet({
  required BuildContext context,
  required ValueChanged<bool> onChanged,
}){

  showModalBottomSheet(
      isScrollControlled: true,
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
            margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h,),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 4.h,
                          width: 44.w,
                          color: ColorPath.mercuryGrey,
                        ),
                      ),
                      SizedBox(height: 30.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add to cart',
                            style: GoogleFonts.urbanist(
                                color: ColorPath.codGrey,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              ///close bottom-sheet
                              popNavigation(context: context);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/close.svg",
                              width: 18.w,
                              height: 18.h,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30.h,),
                      QuantitySelectorAndPricePreview(
                        onChanged: (value){
                          print('value here::::$value');
                          onChanged(true);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        );
      }).whenComplete(() {
  });
}