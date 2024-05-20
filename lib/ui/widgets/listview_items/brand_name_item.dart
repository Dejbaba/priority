import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/view_models/filter_view_model.dart';
import 'package:priority_test/core/view_models/product_view_model.dart';

class BrandNameItem extends StatelessWidget {
  final String sneakerBrand;
  final FilterViewModel filterVm;
  final ProductViewModel productVm;
  const BrandNameItem({super.key, required this.productVm, required this.sneakerBrand, required this.filterVm});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(filterVm.selectedSneakerBrand != sneakerBrand){
          filterVm.selectedSneakerBrand = sneakerBrand;
          productVm.filterList(searchWord: filterVm.selectedSneakerBrand);
        }
      },
      child: Text(
        '$sneakerBrand',
        style: GoogleFonts.urbanist(
            color: sneakerBrand == filterVm.selectedSneakerBrand ? ColorPath.codGrey:ColorPath.nobelGrey,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700
        ),

      ),
    );;
  }
}
