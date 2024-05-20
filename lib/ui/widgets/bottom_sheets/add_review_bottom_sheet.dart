import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/core/view_models/reviews_view_model.dart';
import 'package:priority_test/ui/widgets/floating_flush_bar.dart';
import 'package:priority_test/ui/widgets/star_rating.dart';



///add review bottom sheet
addReviewBottomSheet({
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
                child: Consumer(
                  builder: (context, ref, child){
                    final _reviewVm = ref.watch(reviewVm);
                    return Column(
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
                              'Add Review',
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
                        Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _reviewVm.name,
                              style: GoogleFonts.urbanist(
                                  fontSize: 14.sp, color: ColorPath.codGrey),
                              onChanged: (value){},
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                label:  Text(
                                  'Name',
                                  style: GoogleFonts.urbanist(
                                      color: ColorPath.codGrey,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: ColorPath.codGrey)),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: ColorPath.codGrey)),
                              )),
                        ),
                        SizedBox(height: 25.h,),
                        StarRating(
                          value: _reviewVm.rating,
                          onChanged: (value) => _reviewVm.rating = value,
                          padding: 10.w,

                        ),
                        SizedBox(height: 25.h,),
                        Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _reviewVm.description,
                              style: GoogleFonts.urbanist(
                                  fontSize: 14.sp, color: ColorPath.codGrey),
                              onChanged: (value) {},
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              decoration: InputDecoration(
                                label:  Text(
                                  'Description',
                                  style: GoogleFonts.urbanist(
                                      color: ColorPath.codGrey,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: ColorPath.codGrey)),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: ColorPath.codGrey)),
                              )),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (){

                              final _isValidated = _reviewVm.isFormFilled();
                              if(_isValidated){
                                onChanged(true);
                                popNavigation(context: context);
                              }else{

                                if(_reviewVm.name.text.isEmpty){
                                  ///prompt user to input name
                                  showFloatingFlushBar(
                                    context: context,
                                    message: 'kindly input your name to proceed',
                                    duration: 2,
                                    messageColor: Colors.white,
                                  );
                                  return;
                                }

                                if(_reviewVm.rating == 0){
                                  ///prompt user to input name
                                  showFloatingFlushBar(
                                    context: context,
                                    message: 'kindly select rate ranking for this product to proceed',
                                    duration: 2,
                                    messageColor: Colors.white,
                                  );
                                  return;
                                }

                                showFloatingFlushBar(
                                  context: context,
                                  message: 'kindly input description to proceed',
                                  duration: 2,
                                  messageColor: Colors.white,
                                );
                              }


                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.5.h),
                              elevation: 0,
                              backgroundColor: ColorPath.codGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                            ),
                            child: Text('SUBMIT REVIEW', style: GoogleFonts.urbanist(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700
                            ),), // Button's label
                          ),
                        )
                      ],
                    );
                  }
                ),
              ),
            ),
          ),
        );
      }).whenComplete(() {
  });
}