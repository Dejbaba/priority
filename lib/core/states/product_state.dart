
import 'package:flutter/material.dart';
import 'package:priority_test/core/enums/view_state.dart';

class ProductState extends ChangeNotifier{


  ViewState _state = ViewState.Idle ;
  ViewState get state => _state ;

  ViewState _moreState = ViewState.Idle ;
  ViewState get moreState => _moreState ;

  ViewState _filterState = ViewState.Idle ;
  ViewState get filterState => _filterState ;



  void setState(ViewState viewState){
    _state = viewState ;
    notifyListeners() ;
  }

  void setMoreState(ViewState viewState){
    _moreState = viewState ;
    notifyListeners();
  }

  void setFilterState(ViewState viewState){
    _filterState = viewState;
    notifyListeners() ;
  }
}