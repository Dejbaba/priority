import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/utilities/utilities.dart';
import 'package:priority_test/core/view_models/product_details_view_model.dart';
import 'package:priority_test/core/view_models/reviews_view_model.dart';
import 'package:priority_test/ui/widgets/custom_appbar.dart';
import 'package:priority_test/ui/widgets/empty_state.dart';
import 'package:priority_test/ui/widgets/leading_icon.dart';
import 'package:priority_test/ui/widgets/listview_items/review_item.dart';

class AllReviews extends StatelessWidget {
  const AllReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child){
        final _productDetailsVm = ref.watch(productDetailsVm);
        final _reviewVm = ref.watch(reviewVm);
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Review (${_productDetailsVm.selectedProduct.totalReviews})',
            actionIcons: [
              Padding(
                padding: EdgeInsets.only(right: 24.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/star.svg",
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(width: 4.w,),
                    Text(
                      '${_productDetailsVm.selectedProduct.averageRating}',
                      style: GoogleFonts.urbanist(
                          color: ColorPath.codGrey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
          body: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30.h,
                  margin: EdgeInsets.only(top: 20.h),
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 30.w),
                    itemCount: _productDetailsVm.ratingCategories.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final _ratingCategory = _productDetailsVm.ratingCategories[index];
                      return Container(
                        padding: EdgeInsets.only(right: 20.w),
                        child: GestureDetector(
                          onTap: (){
                            if(_productDetailsVm.selectedRatingCategory != _ratingCategory){
                              _productDetailsVm.selectedRatingCategory = _ratingCategory;
                              _reviewVm.filterReviewList(searchWord: Utilities.splitAndFormatInput(input: _ratingCategory));
                            }
                      },
                          child: Text(
                            '$_ratingCategory',
                            style: GoogleFonts.urbanist(
                                color: _ratingCategory == _productDetailsVm.selectedRatingCategory ? ColorPath.codGrey:ColorPath.nobelGrey,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700
                            ),

                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30.h,),
                if(_reviewVm.filteredReviews.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 98.h),
                    itemCount: _reviewVm.filteredReviews.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ReviewItem(
                        review: _reviewVm.filteredReviews[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 25.h,);
                    },
                  ),
                )
                else Expanded(
                  child: Center(child: EmptyState(
                    message: 'Reviews Not Found',
                  )),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
