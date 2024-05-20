import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/view_models/filter_view_model.dart';
import 'package:priority_test/ui/widgets/donut_slider_thumb_shape.dart';

class CustomSlider extends StatelessWidget {

  const CustomSlider({super.key});

  // final List<double> divisions = [0.0, 200.0, 750.0, 1750.0];
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child){
        final _filterVm = ref.watch(filterVm);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  showValueIndicator: ShowValueIndicator.never,
                  rangeThumbShape: DonutRangeSliderThumbShape(
                    thumbRadius: 15.0,
                    holeRadius: 8.0,
                  ),
                  activeTrackColor: ColorPath.codGrey,
                  inactiveTrackColor: ColorPath.concreteGrey,
                  trackHeight: 4.0,
                  thumbColor: ColorPath.codGrey,
                  overlayColor: Colors.white,
                ),
                child: RangeSlider(
                  values: _filterVm.currentRangeValues,
                  min: 0,
                  max: (_filterVm.divisions.length - 1).toDouble(),
                  divisions:_filterVm.divisions.length - 1,
                  onChanged:(RangeValues values)=>_filterVm.currentRangeValues = values,
                  //onChangeEnd:(RangeValues values)=>_filterVm.currentRangeValues = values,
                )),
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLabel('\$0', 0, _filterVm),

                  _buildLabel('\$200', 1, _filterVm),

                  _buildLabel('\$750', 2, _filterVm),

                  _buildLabel('\$1750', 3, _filterVm),
                ],
              ),
            ),
          ],
        );
      }
    );
  }

  _buildLabel(String label, int index, FilterViewModel filterVm) {
    bool isSelected =
        index == filterVm.currentRangeValues.start || index == filterVm.currentRangeValues.end;
    return Text(
      label,
      style: GoogleFonts.urbanist(
          color: isSelected ? ColorPath.codGrey:ColorPath.mercuryGrey,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700),
    );
  }
}
