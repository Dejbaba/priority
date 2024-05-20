import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:priority_test/core/models/product.dart';
import 'package:priority_test/core/utilities/auth_utils.dart';

class WishlistService{

  static final wishlistCollection = FirebaseFirestore.instance
      .collection('wishlists')
      .doc(AuthUtils.userId)
      .collection('wishlist');

  ///adds a new user wishlist to fireStore
  static setNewWishlist({required Product product})async{
    await wishlistCollection.doc(product.wishlistId).set(product.toJson());
  }

  ///fetches user wishlist
  static Future<List<Product>> fetchWishlist()async{
    try{
      final querySnapshot = await wishlistCollection.orderBy('createdDate', descending: true).get();
      final _userWishlist = querySnapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
      return _userWishlist;
    }catch(e){
      return [];
    }
  }

  ///Deletes item from wishlist
  static deleteWishlist({required String wishlistId})async{
    await wishlistCollection
        .doc(wishlistId)
        .delete();
  }


}