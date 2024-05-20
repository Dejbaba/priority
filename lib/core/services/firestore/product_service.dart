import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:priority_test/core/services/firestore/parent_service.dart';



class ProductService{
  static Query query = FirebaseFirestore.instance.collection('products').limit(10);
  static CollectionReference productsRef =  FirebaseFirestore.instance.collection('products');
  static Query filteredQuery = productsRef;

  ///fetch single product
  static Future<DocumentSnapshot> fetchSingleProduct({required String productId})async{
    return  await productsRef
        .doc(productId)
        .get();
  }

}