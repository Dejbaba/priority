import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/models/cart_product.dart';
import 'package:priority_test/core/services/firestore/cart_service.dart';
import 'package:priority_test/core/states/cart_state.dart';
import 'package:priority_test/core/utilities/utilities.dart';
import 'package:priority_test/core/view_models/product_details_view_model.dart';
import 'package:uuid/uuid.dart';

class CartViewModel extends CartState{

  String? _message;
  String? get message => _message;

  ///flags used on the UI
  bool get isCartEmpty => _cartProducts.isEmpty;
  double get subTotalPrice => calculateSubTotal();

  ///list of cart products
  List<CartProduct> _cartProducts = [];
  List<CartProduct> get cartProducts => _cartProducts;

  addToCart({required ProductDetailsViewModel productDetailsVm}) async {
    setCartActionState(ViewState.Busy);
    try{

      /// Generate a unique ID for the cart item
      String cartItemId = Utilities.generateId();

      ///instantiate a new cart
      final newCart = CartProduct(
        id: cartItemId,
        productId: productDetailsVm.selectedProduct.id,
        productName: productDetailsVm.selectedProduct.productName,
        url: productDetailsVm.selectedProduct.productUrls![0],
        size: productDetailsVm.selectedSize,
        color: productDetailsVm.selectedColor,
        brandName: productDetailsVm.selectedProduct.brandName,
        quantity: productDetailsVm.selectedQuantity,
        availableQuantity: productDetailsVm.selectedProduct.quantity,
        price: productDetailsVm.selectedProduct.price,
        createdDate: DateTime.now(),
        updatedDate: DateTime.now(),
      );

      /// Checks if the item already exists in the cart
      final querySnapshot = await CartService.isItemExist(newCart: newCart);

      if(querySnapshot.docs.isNotEmpty){
        /// Item exists in cart
        /// Update the existing cart item quantity
        final existingCartItem = querySnapshot.docs.first;
        final updatedQuantity = existingCartItem['quantity'] + newCart.quantity!;
        await existingCartItem.reference.update({
          'quantity': updatedQuantity,
          'updatedDate': DateTime.now(),
        });
        print('updated cart');
      }
      else{
        ///create new item in cart
        await CartService.setNewCart(newCart: newCart);

        ///add item to in-app cart list
        _cartProducts.add(newCart);
        print('added to cart');
      }
      setCartActionState(ViewState.Retrieved);
    }catch(e){
      print('failed');
      _message = e.toString();
      setCartActionState(ViewState.Error);
    }

  }

  fetchCartItems() async{
    setState(ViewState.Busy);
    try{
      _cartProducts = await CartService.fetchCart();
      setState(ViewState.Retrieved);
    }catch(e){
      _message = e.toString();
      setState(ViewState.Error);
    }
  }

  updateCart({required String cartItemId, required int newQuantity, required int index}) async {
   setCartActionState(ViewState.Busy);
   try{
     await CartService.updateCart(cartItemId: cartItemId, newQuantity: newQuantity);
     ///update in-app data too
     _cartProducts[index].quantity = newQuantity;
     _message = 'Item updated successfully';
     setCartActionState(ViewState.Retrieved);
   }catch(e){
     _message = e.toString();
     setCartActionState(ViewState.Error);
   }
  }

  deleteCart({required String cartId, required int index})async{
    try{
      await CartService.deleteItem(cartId: cartId);
      ///remove item from in-app cart list
      _cartProducts.removeAt(index);
      _message = 'item deleted successfully';
      setCartActionState(ViewState.Retrieved);
    }catch(e){
      _message = e.toString();
      setCartActionState(ViewState.Error);
    }
  }

  clearCart()async{
    await CartService.deleteCartItemsAfterOrder();
    _cartProducts.clear();
    notifyListeners();
  }


  ///calculates the subtotal of a user's cart
  double calculateSubTotal(){

    double _subTotal = 0;

    ///iterate through all the cart products
    _cartProducts.forEach((cartProduct) {
      _subTotal = _subTotal + (double.tryParse(cartProduct.price!.toString())! * cartProduct.quantity!);
    });

    return _subTotal;
  }



}

final cartVm = ChangeNotifierProvider<CartViewModel>((ref){
  return CartViewModel();
});