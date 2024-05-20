import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/models/product.dart';
import 'package:priority_test/core/services/firestore/wishlist_service.dart';
import 'package:priority_test/core/states/wishlist_state.dart';
import 'package:priority_test/core/utilities/utilities.dart';

class WishlistViewModel extends WishlistState{

  ///flags used on the UI
  bool get isWishlistNotEmpty => _wishListProducts.isNotEmpty;

  String? _message;
  String? get message => _message;

  List<Product> _wishListProducts = [];
  List<Product> get wishListProducts => _wishListProducts;

  ///fetches user wishlist
  fetchWishlist() async{
    setState(ViewState.Busy);
    try{
      _wishListProducts = await WishlistService.fetchWishlist();
      setState(ViewState.Retrieved);
    }catch(e){
      _message = e.toString();
      setState(ViewState.Error);
    }
  }


  ///adds a new product to wishlist
  addToWishlist({required Product product}) async {
    setWishListActionState(ViewState.Busy);
    try{
      /// Generate a unique ID for the cart item
      String wishlistId = Utilities.generateId();

      ///update wishlist id field
      product.wishlistId = wishlistId;

      ///create new item in cart
      await WishlistService.setNewWishlist(product: product);

      ///add item to in-app wishlist
      _wishListProducts.add(product);
      _message = 'Product added to wishlist';
      setWishListActionState(ViewState.Retrieved);
    }catch(e){
      print('failed');
      _message = e.toString();
      setWishListActionState(ViewState.Error);
    }

  }

  ///deletes a wishlist item
  deleteWishlist({required String productId})async{
    setWishListActionState(ViewState.Busy);
    try{
      ///get position index of product
      int _positionIndex = _wishListProducts.indexWhere((wishlistProduct) => wishlistProduct.id == productId);
      await WishlistService.deleteWishlist(wishlistId: _wishListProducts[_positionIndex].wishlistId!);
      ///remove item from in-app cart list
      _wishListProducts.removeAt(_positionIndex);
      _message = 'Product deleted from wishlist successfully';
      setWishListActionState(ViewState.Retrieved);
    }catch(e){
      _message = e.toString();
      setWishListActionState(ViewState.Error);
    }
  }



  ///check if a product exists in the wish-list
  bool isProductInWishList({required String productId}){

    int positionIndex = _wishListProducts.indexWhere((wishListProduct) => wishListProduct.id == productId);

    ///product does not exist in wishlist
    if(_wishListProducts.isEmpty || positionIndex < 0)
      return false;

    return true;
  }


}

final wishlistVm = ChangeNotifierProvider<WishlistViewModel>((ref){
  return WishlistViewModel();
});