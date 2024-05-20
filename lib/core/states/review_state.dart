
import 'package:flutter/material.dart';
import 'package:priority_test/core/enums/view_state.dart';

class ReviewState extends ChangeNotifier{


  ViewState _state = ViewState.Idle ;
  ViewState get state => _state ;

  ViewState _reviewActionState = ViewState.Idle ;
  ViewState get reviewActionState => _reviewActionState ;



  void setState(ViewState viewState){
    _state = viewState ;
    notifyListeners() ;
  }

  void setReviewActionState(ViewState viewState){
    _reviewActionState = viewState ;
    notifyListeners() ;
  }
}