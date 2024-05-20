

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:priority_test/core/models/review.dart';

class ReviewService{
  static CollectionReference allReviewsRef = FirebaseFirestore.instance.collection('all_reviews');


  ///fetches reviews by productID
  static Future<List<Review>> fetchReviewsByProductId({required String productId})async{
    try{
      final productReviewsRef = allReviewsRef
          .doc(productId)
          .collection('reviews');
      final querySnapshot = await productReviewsRef.get();
      final _allReviews = querySnapshot.docs.map((doc) => Review.fromMap(doc.data())).toList();
      return _allReviews;
    }catch(e){
      return [];
    }
  }

  ///submits a new review for a product to fireStore
  static submitReview({required Review review})async{
    final DocumentReference productDocRef = allReviewsRef.doc(review.productId);
    final CollectionReference productReviewsRef = productDocRef.collection('reviews');

    /// Add a new review document without an ID to let Firestore generate one
    await productReviewsRef.doc(review.id).set(review.toJson());
  }
}