
import 'package:flutter/material.dart';
import 'package:priority_test/core/enums/view_state.dart';

class CartState extends ChangeNotifier{


  ViewState _state = ViewState.Idle ;
  ViewState get state => _state ;

  ViewState _cartActionState = ViewState.Idle ;
  ViewState get cartActionState => _cartActionState ;




  void setState(ViewState viewState){
    _state = viewState ;
    notifyListeners() ;
  }

  void setCartActionState(ViewState viewState, {bool refreshUi = true}){
    _cartActionState = viewState ;
    if(refreshUi)
      notifyListeners() ;
  }

}