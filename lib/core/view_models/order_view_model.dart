import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/models/order_detail.dart';
import 'package:priority_test/core/models/payment_detail.dart';
import 'package:priority_test/core/services/firestore/order_service.dart';
import 'package:priority_test/core/states/order_state.dart';
import 'package:priority_test/core/utilities/utilities.dart';
import 'package:priority_test/core/view_models/cart_view_model.dart';
import 'package:uuid/uuid.dart';
import 'package:priority_test/core/models/order.dart' as Order;

class OrderViewModel extends OrderState{

  String? _message;
  String? get message => _message;


  ///list of orders
  List<Order.Order> _orders = [];
  List<Order.Order> get orders => _orders;


  ///creates a new order in fireStore
  createOrder({required CartViewModel cartVm}) async {
    setState(ViewState.Busy);
    try {


      /// Generate a unique ID for the order
      String orderId = Utilities.generateId();

      ///create order detail list
      List<OrderDetail> _orderDetails = [];
      ///iterates through cart products to create order detail
      cartVm.cartProducts.forEach((cartProduct) {
        final orderDetail = OrderDetail(
          quantity: cartProduct.quantity,
          price: cartProduct.price,
          brandName: cartProduct.brandName,
          productName: cartProduct.productName,
          color: cartProduct.color,
          productId: cartProduct.productId,
          size: cartProduct.size
        );
        ///add order detail to order details list
        _orderDetails.add(orderDetail);
      });

      ///create payment detail
      final _paymentDetail = PaymentDetail(
        shipping: 20, ///as seen on the design
        subTotal: cartVm.subTotalPrice,
        total: cartVm.subTotalPrice + 20 ///subTotal + shipping
      );

      ///instantiate a new order
      final newOrder = Order.Order(
        id: orderId,
        location: 'Semarang, Indonesia', ///as seen on the design
        paymentMethod: 'Credit Card', ///as seen on the design
        orderDetail: _orderDetails,
        paymentDetail: _paymentDetail,
        createdDate: DateTime.now()
      );

      ///create new order in order collection
      await OrderService.setNewOrder(order: newOrder);

      ///clears user cart after order has been successfully created in fireStore
      cartVm.clearCart();


      ///add order to in-app list
      _orders.add(newOrder);

      setState(ViewState.Retrieved);

    } catch (e) {
      _message = e.toString();
      setState(ViewState.Error);
    }
  }

  ///fetches user orders from fireStore
  fetchOrders() async{
    setState(ViewState.Busy);
    try{
     _orders = await OrderService.fetchOrders();
      setState(ViewState.Retrieved);
    }catch(e){
      _message = e.toString();
      setState(ViewState.Error);
    }
  }

  ///check if a product has been bought/ordered by a user
  bool isProductPurchased({required String productId}){
    int? _positionIndex = -1;
    for(Order.Order _order in _orders){
      _positionIndex = _order.orderDetail!.indexWhere((orderDetail) => orderDetail.productId == productId);
      if(_positionIndex >= 0)
        break;
    }
    return _positionIndex! >= 0;
  }


}

final orderVm = ChangeNotifierProvider<OrderViewModel>((ref){
  return OrderViewModel();
});