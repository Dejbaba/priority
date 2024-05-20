import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:priority_test/core/models/order.dart' as Order;
import 'package:priority_test/core/utilities/auth_utils.dart';

class OrderService{
  static CollectionReference allOrdersRef = FirebaseFirestore.instance
      .collection('user_orders');

  static final usersOrdersRef = allOrdersRef.doc(AuthUtils.userId)
      .collection('orders');

  ///creates a new order for user
  static setNewOrder({required Order.Order order})async{
    await usersOrdersRef.doc(order.id).set(order.toJson());
  }

  static Future<List<Order.Order>> fetchOrders()async{
    try{
      final querySnapshot = await usersOrdersRef.orderBy('createdDate', descending: true).get();
      final _allOrders = querySnapshot.docs.map((doc) => Order.Order.fromMap(doc.data())).toList();
      return _allOrders;
    }catch(e){
      return [];
    }
  }
}