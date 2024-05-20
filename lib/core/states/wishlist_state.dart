
import 'package:flutter/material.dart';
import 'package:priority_test/core/enums/view_state.dart';

class WishlistState extends ChangeNotifier{


  ViewState _state = ViewState.Idle ;
  ViewState get state => _state ;

  ViewState _wishlistActionState = ViewState.Idle ;
  ViewState get wishlistActionState => _wishlistActionState ;




  void setState(ViewState viewState){
    _state = viewState ;
    notifyListeners() ;
  }

  void setWishListActionState(ViewState viewState){
    _wishlistActionState = viewState ;
      notifyListeners() ;
  }

}