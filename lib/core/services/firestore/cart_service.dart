import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:priority_test/core/models/cart_product.dart';
import 'package:priority_test/core/utilities/auth_utils.dart';

class CartService{
  static final cartCollection = FirebaseFirestore.instance
      .collection('user_carts')
      .doc(AuthUtils.userId)
      .collection('carts');

  ///returns a query snapshot that confirms if an item exists in the cart already
  static Future<QuerySnapshot> isItemExist({required CartProduct newCart})async{
    return await cartCollection
        .where('productId', isEqualTo: newCart.productId)
        .where('size', isEqualTo: newCart.size)
        .where('color', isEqualTo: newCart.color)
        .get();
  }

  ///adds a new user cart to fireStore
  static setNewCart({required CartProduct newCart})async{
    await cartCollection.doc(newCart.id).set(newCart.toJson());
  }

  ///fetches user cart
  static Future<List<CartProduct>> fetchCart()async{
    try{
      final querySnapshot = await cartCollection.orderBy('createdDate', descending: true).get();
      final _userCart = querySnapshot.docs.map((doc) => CartProduct.fromMap(doc.data())).toList();
      return _userCart;
    }catch(e){
      return [];
    }
  }

  ///updates user cart
  static updateCart({required String cartItemId, required int newQuantity})async{
    final cartItemRef = cartCollection
        .doc(cartItemId);

    /// Get the current cart item
    final cartItemDoc = await cartItemRef.get();

    if (cartItemDoc.exists) {
      final cartItemData = cartItemDoc.data();
      if (cartItemData != null) {
        /// Update the quantity and price in fireStore
        await cartItemRef.update({
          'quantity': newQuantity,
          'updatedDate': DateTime.now(),
        });
      }
    }
  }

  ///Deletes item from cart
  static deleteItem({required String cartId})async{
    await cartCollection
        .doc(cartId)
        .delete();
  }

  ///deletes all items in user's cart when an order is successfully created
  static deleteCartItemsAfterOrder() async {

      /// Fetches all documents in the 'carts' sub-collection
      QuerySnapshot cartsQuerySnapshot = await cartCollection.get();

      /// Delete each document within the 'carts' sub-collection
      for (DocumentSnapshot cartDocSnapshot in cartsQuerySnapshot.docs) {
        await cartDocSnapshot.reference.delete();
      }
  }
}