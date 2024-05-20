
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

/// push
pushNavigation(
    {required BuildContext context, required Widget widget, String? routeName, PageTransitionType? transitionType, Duration? transitionDuration}) async {
  Navigator.push(
      context,
      PageTransition(
          type: transitionType ?? PageTransitionType.rightToLeft,
          settings: RouteSettings(name: routeName),
          child: widget,
          duration: transitionDuration ?? Duration(milliseconds: 400)));
}

///push and clear
pushAndClearNavigation(
    {required BuildContext context, required Widget widget, String? routeName, String? clearRoute, PageTransitionType? transitionType, Duration? transitionDuration}) async {
  Navigator.pushAndRemoveUntil(context, PageTransition(
      type: transitionType ?? PageTransitionType.rightToLeft,
      child: widget,
      settings: RouteSettings(name: routeName),
      duration: transitionDuration ?? Duration(milliseconds: 400)),
      ModalRoute.withName(clearRoute ?? '/'));
}

///push and clear all
pushAndClearAllNavigation(
    {required BuildContext context, required Widget widget, String? routeName, PageTransitionType? transitionType, Duration? transitionDuration}) async {
  Navigator.pushAndRemoveUntil(context, PageTransition(
      type: transitionType ?? PageTransitionType.rightToLeft,
      child: widget,
      settings: RouteSettings(name: routeName),
      duration: transitionDuration ?? Duration(milliseconds: 400)),
          (Route<dynamic> route) => false
  );
}

/// push replacement
replaceNavigation(
    {required BuildContext context, String? routeName, required Widget widget, PageTransitionType? transitionType, Duration? transitionDuration}) async {
  Navigator.pushReplacement(
      context,
      PageTransition(
          type: transitionType ?? PageTransitionType.rightToLeft,
          child: widget,
          settings: RouteSettings(name: routeName),
          duration: transitionDuration ?? Duration(milliseconds: 400)));
}

/// pop
popNavigation({required BuildContext context}){
  Navigator.of(context).pop();
}

///pop until
popUntilNavigation({required BuildContext context, String? route}){
  Navigator.popUntil(
      context, ModalRoute.withName(route!));
}


