
import 'package:flutter/material.dart';
import 'package:priority_test/core/enums/view_state.dart';

class OrderState extends ChangeNotifier{


  ViewState _state = ViewState.Idle ;
  ViewState get state => _state ;



  void setState(ViewState viewState){
    _state = viewState ;
    notifyListeners() ;
  }
}