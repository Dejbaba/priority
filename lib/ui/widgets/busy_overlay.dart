import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';



class BusyOverlay extends StatelessWidget {
  final Widget child;
  final String title;
  final bool show;
  final double opacity;

  const BusyOverlay(
      {Key? key,
        required this.child,
        this.title = '',
        this.show = false,
        this.opacity = 0.7})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(children: <Widget>[
          child,
          IgnorePointer(
            ignoring: !show,
            child: Opacity(
                opacity: show ? 1.0 : 0.0,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(opacity),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(ColorPath.codGrey)),
                      Text(
                        title,
                        style: GoogleFonts.urbanist(
                            color: ColorPath.codGrey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                )),
          ),
        ]));
  }
}
