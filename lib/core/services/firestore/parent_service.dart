import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:priority_test/core/models/product.dart';
import 'package:priority_test/core/models/review.dart';
import 'package:priority_test/core/utilities/utilities.dart';


class ParentService{

  ///seeds in data for product list into firestore(should be runned once)
  seedProductData()async{
    List<String> brands = [
      'NIKE',
      // 'Puma',
      'Adidas',
      // 'Reebok',
      // 'Vans',
      'Jordan'
    ];

    List<double> prices = [
      235.00,
      // 'Puma',
      400.00,
      // 'Reebok',
      // 'Vans',
      1750.00
    ];

    List<String> genders = [
      'Man',
      // 'Puma',
      'Woman',
      // 'Reebok',
      // 'Vans',
      'Unisex'
    ];

    List<String> brandLogos = [
      'assets/images/brands/nike.svg',
      // 'assets/images/brands/puma.svg',
      'assets/images/brands/adidas.svg',
      // 'assets/images/brands/reebok.svg',
      // 'assets/images/brands/vans.svg',
      'assets/images/brands/jordan.svg',
    ];

    List<String> shoeUrls = [
      'assets/images/shoes/nike_1.png',
      // 'assets/images/shoes/puma_1.png',
      'assets/images/shoes/adidas_1.png',
      // 'assets/images/shoes/reebok_1.png',
      // 'assets/images/shoes/vans_1.png',
      'assets/images/shoes/jordan_1.png',
    ];

    final random = Random();
    List<Product> allProducts = [];

    for(int index = 0; index <= 69; index++){
      int randomNumber = random.nextInt(3);
      Product newProduct = Product(
        productName: '${brands[randomNumber]} Retro High ${index + 1}',
        totalReviews: (random.nextInt(3) + 1),
        brandLogo: '${brandLogos[randomNumber]}',
        brandName: '${brands[randomNumber]}',
        colors: ['Black', 'White', 'Red', 'Teal Green', 'Blue'],
        createdDate: DateTime.now(),
        id: '',
        gender: '${genders[random.nextInt(3)]}',
        price: prices[randomNumber],
        productUrls: ['${shoeUrls[randomNumber]}', '${shoeUrls[random.nextInt(3)]}', '${shoeUrls[random.nextInt(3)]}'],
        quantity: random.nextInt(17) + 4,
        sizes: ['39', '39.5', '40', '40.5', '41'],
      );

      allProducts.add(newProduct);
    }

    final CollectionReference productsRef = FirebaseFirestore.instance.collection('products');



    for (Product product in allProducts) {
      print('got here to upload');
        // Add a new document without an ID
        DocumentReference docRef = await productsRef.add(product.toJson());


        // Get the generated ID
        String generatedId = docRef.id;

        // Update the document with the generated ID
        await docRef.update({"id": generatedId});

    }

  }

  ///seeds in data for review list into firestore(should be runned once after products have been uploaded)
  seedReviewData()async{

    List<String> reviewerNames = [
      'Nolan Carder',
      'Maria Soris',
      'Gretchen Septimus',
      'Roger Stanton',
      'Hannah Levin',

    ];
    List<String> descriptions = [
      'Awesome Products',
      'Got what i wanted',
      'not so good... not so bad',
      'Manageable',
      'Terrible!!! got the opposite of what i wanted',
    ];

    List<double> ratings = [
      5.0,
      4.5,
      3.5,
      3.0,
      1.5,
    ];
    final random = Random();
    final CollectionReference productsRef = FirebaseFirestore.instance.collection('products');

    /// Fetch all product documents
    QuerySnapshot productsSnapshot = await productsRef.get();

    /// Loop through each product document
    for (var productDoc in productsSnapshot.docs) {
      String productId = productDoc.id;
      int numberOfReviews = productDoc['totalReviews'];
      print('number of reviews here: $numberOfReviews>>>');


      for(int index = 0; index <=numberOfReviews-1; index++){
        int randomNumber = random.nextInt(4);
        /// Generate a unique ID for the cart item
        String reviewId = Utilities.generateId();
        /// Create a sample review
        Review review = new Review(
          id: reviewId,
          productId: productId,
          reviewerName: '${reviewerNames[index]}',
          productName: productDoc['productName'],
          url: '${Utilities.reviewerPics[index]}',
          description: '${descriptions[randomNumber]}',
          rating:  ratings[randomNumber],
          createdDate: DateTime.now(),
        );

        /// Add the review for the product
        await addReview(review);
      }


    }
  }

  ///adds a review(used when seeding review data into fireStore)
  addReview(Review review) async {
    final CollectionReference reviewsRef = FirebaseFirestore.instance.collection('all_reviews');
    final DocumentReference productDocRef = reviewsRef.doc(review.productId);
    final CollectionReference productReviewsRef = productDocRef.collection('reviews');

    /// Add a new review document without an ID to let Firestore generate one
    await productReviewsRef.doc(review.id).set(review.toJson());

    print('added>>>>');
  }

  /// gets query
  static Future<QuerySnapshot> getQuery({required Query query})async{
     return await query.get();
  }
}