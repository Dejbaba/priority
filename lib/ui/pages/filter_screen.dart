import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/core/view_models/filter_view_model.dart';
import 'package:priority_test/core/view_models/product_view_model.dart';
import 'package:priority_test/ui/widgets/busy_overlay.dart';
import 'package:priority_test/ui/widgets/custom_appbar.dart';
import 'package:priority_test/ui/widgets/custom_slider.dart';
import 'package:priority_test/ui/widgets/floating_flush_bar.dart';
import 'package:priority_test/ui/widgets/listview_items/brand_details_item.dart';
import 'package:priority_test/ui/widgets/listview_items/filter_color_item.dart';
import 'package:priority_test/ui/widgets/listview_items/gender_item.dart';
import 'package:priority_test/ui/widgets/listview_items/sort_by_item.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {

  @override
  void initState() {
    ref.read(filterVm).reset(refreshUi: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _filterVm = ref.watch(filterVm);
    final _productVm = ref.watch(productVm);
    return BusyOverlay(
      show: _productVm.filterState == ViewState.Busy,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Filter',
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 20.w, bottom: 30.h),
                children: [
                  availableBrands(context: context, filterVm: _filterVm),
                  SizedBox(
                    height: 30.h,
                  ),
                  priceRange(context: context, filterVm: _filterVm),
                  SizedBox(
                    height: 30.h,
                  ),
                  sortBy(context: context, filterVm: _filterVm),
                  SizedBox(height: 30.h,),
                  gender(context: context, filterVm: _filterVm),
                  SizedBox(height: 30.h,),
                  color(context: context, filterVm: _filterVm)

                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: ColorPath.altoGrey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 0.75), // changes position of shadow
                  ),
                ],

              ),
              child: SafeArea(
                child: Container(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: ()=>_filterVm.reset(),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.5.h, horizontal: 42.5.w),
                              elevation: 0,
                              side: BorderSide(color: ColorPath.mercuryGrey),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                            ),
                            child: Text('RESET (${_filterVm.filterCategories.length})', style: GoogleFonts.urbanist(
                                color: ColorPath.codGrey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700
                            ),), // Button's label
                          ),
                        ),
                      ),
                      SizedBox(width: 15.w,),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: ()async{
                              await _productVm.fetchFilteredProducts(filterVm: _filterVm);
                              if(_productVm.filterState == ViewState.Retrieved){
                                ///pop users back to discover screen and show
                                ///success message
                                popNavigation(context: context);
                                showFloatingFlushBar(
                                  context: context,
                                  message: _productVm.message!,
                                  duration: 2,
                                  bgColor: Colors.green,
                                  messageColor: Colors.white,
                                );
                              }else{
                                ///display error message to user
                                showFloatingFlushBar(
                                  context: context,
                                  message: _productVm.message!,
                                  duration: 2,
                                  messageColor: Colors.white,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.5.h, horizontal: 54.w),
                              elevation: 0,
                              backgroundColor: ColorPath.codGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                            ),
                            child: Text('APPLY', style: GoogleFonts.urbanist(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700
                            ),), // Button's label
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///brands
  availableBrands({required BuildContext context, required FilterViewModel filterVm}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: 30.w),
          child: Text(
            'Brands',
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          height: 97.h,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            itemCount: filterVm.brandLogos.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final _brandLogo = filterVm.brandLogos[index];
              final _brandName = filterVm.brandNames[index];
              return BrandDetailsItem(
                  index: index,
                  brandLogo: _brandLogo,
                  brandName: _brandName,
                  filterVm: filterVm);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10.w,
              );
            },
          ),
        )
      ]);

  ///price range
  priceRange({required BuildContext context, required FilterViewModel filterVm}) =>
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Price Range',
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomSlider(
          )
        ]),
      );

  ///sort
  sortBy({required BuildContext context, required FilterViewModel filterVm}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: 30.w),
          child: Text(
            'Sort By',
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
          height: 40.h,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 30.w,right: 30.w),
            itemCount: filterVm.sortByOptions.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final _sortByOption = filterVm.sortByOptions[index];
              return SortByItem(sortByOption: _sortByOption, filterVm: filterVm);
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 10.w,);
            },

          ))]);

  ///gender
  gender({required BuildContext context, required FilterViewModel filterVm}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: 30.w),
          child: Text(
            'Gender',
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
            height: 40.h,
            child: ListView.separated(
              padding: EdgeInsets.only(left: 30.w,right: 30.w),
              itemCount: filterVm.genders.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final _genderOption = filterVm.genders[index];
                return GenderItem(genderOption: _genderOption, filterVm: filterVm);
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 10.w,);
              },

            ))]);

  ///color
  color({required BuildContext context, required FilterViewModel filterVm}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(left: 30.w),
          child: Text(
            'Color',
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Container(
            height: 40.h,
            child: ListView.separated(
              padding: EdgeInsets.only(left: 30.w,right: 30.w),
              itemCount: filterVm.filterColors.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final _color = filterVm.filterColors[index];
                return FilterColorItem(color: _color, index: index, filterVm: filterVm);
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 10.w,);
              },

            ))]);




}
