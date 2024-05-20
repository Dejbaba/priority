import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/models/product.dart';
import 'package:priority_test/core/models/review.dart';
import 'package:priority_test/core/services/firestore/review_service.dart';
import 'package:priority_test/core/states/review_state.dart';
import 'package:priority_test/core/utilities/utilities.dart';

class ReviewsViewModel extends ReviewState{

  String? _message;
  List<Review> _allReviews = [];

  List<Review> _filteredReviews = [];
  List<Review> get allReviews => _allReviews;

  List<Review> get filteredReviews => _filteredReviews;
  String? get message => _message;

  int _rating = 0;
  int get rating => _rating;
  set rating(int val){
    _rating = val;
    notifyListeners();
  }

  ///reviewer name text controller
  TextEditingController _name = TextEditingController();
  TextEditingController get name => _name;

  ///reviewer description text controller
  TextEditingController _description = TextEditingController();
  TextEditingController get description => _description;

  ///filters review list by quality of review(5 star, 4 star...)
  filterReviewList({required String searchWord}) {
    if(searchWord.toLowerCase() == 'all'){
      _filteredReviews = _allReviews;
    }else{
      _filteredReviews = _allReviews
          .where((review) =>
          Utilities.splitAndFormatInput(input: review.rating!.toString(), splitRating: true) == Utilities.splitAndFormatInput(input: searchWord))
          .toList();
    }
    notifyListeners();
  }

  ///fetches reviews by productId
  getReviewsByProductId({required String productId}) async {
    setState(ViewState.Busy);
    try {
      _allReviews = await ReviewService.fetchReviewsByProductId(productId: productId);
      _filteredReviews = List.of(_allReviews);
      setState(ViewState.Retrieved);
    } catch (e) {
      _message = e.toString();
    setState(ViewState.Error);
    }
  }

  ///submit a new review to fireStore
  submitReview({required Product product})async{
    setReviewActionState(ViewState.Busy);
    try{
      final _randomNumber = Random().nextInt(5);
      /// Generate a unique ID for the cart item
      String reviewId = Utilities.generateId();
      final _newReview = new Review(
          id: reviewId,
          productName: product.productName,
          productId: product.id,
          description: _description.text,
          reviewerName: _name.text,
          url: '${Utilities.reviewerPics[_randomNumber]}',
          rating: _rating.toDouble(),
          createdDate: DateTime.now()
      );
      await ReviewService.submitReview(review: _newReview);
      _allReviews.insert(0, _newReview);
      _filteredReviews..insert(0, _newReview);
      _message = 'Review Submitted Successfully';
      setReviewActionState(ViewState.Retrieved);
    }catch(e){
      _message = e.toString();
      setReviewActionState(ViewState.Error);
    }
  }




  ///validates user input in review bottom-sheet
  bool isFormFilled(){
    if(_name.text.isEmpty || _description.text.isEmpty || _rating == 0)
      return false;

    return true;
  }

  ///clear user rating inputs
  clearInputs(){
    _name.clear();
    _description.clear();
    _rating = 0;
  }


}

final reviewVm = ChangeNotifierProvider<ReviewsViewModel>((ref){
  return ReviewsViewModel();
});