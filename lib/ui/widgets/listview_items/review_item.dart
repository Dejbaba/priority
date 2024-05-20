import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/models/review.dart';
import 'package:priority_test/core/utilities/utilities.dart';

import '../../../core/constants/color_path.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "${review.url}",
          width: 40.w,
          height: 40.h,
        ),
        SizedBox(width: 15.w,),
        Expanded(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${review.reviewerName}',
                    style: GoogleFonts.urbanist(
                        color: ColorPath.ebonyBlack,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700
                    ),
                  ),Text(
                    '${Utilities.actualDay(review.createdDate!)}',
                    style: GoogleFonts.urbanist(
                        color: ColorPath.nobelGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h,),
              RatingBar.builder(
                initialRating: double.tryParse(review.rating.toString() ?? '0') ?? 0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 12.h,
                itemPadding: EdgeInsets.symmetric(horizontal: 3.w),
                itemBuilder: (context, _) => SvgPicture.asset(
                  "assets/icons/star.svg",
                  width: 12.w,
                  height: 12.h,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(height: 10.h,),
              Text(
                '${review.description}',
                style: GoogleFonts.urbanist(
                    color: ColorPath.ebonyBlack,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 2
                ),

              )

            ],
          ),
        )
      ],
    );
  }
}
