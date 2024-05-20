import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/models/product.dart';
import 'package:priority_test/core/services/firestore/parent_service.dart';
import 'package:priority_test/core/services/firestore/product_service.dart';
import 'package:priority_test/core/states/product_state.dart';
import 'package:priority_test/core/view_models/filter_view_model.dart';
import 'package:priority_test/core/view_models/product_details_view_model.dart';

class ProductViewModel extends ProductState{

  String? _message;
  String? get message => _message;

  ///list of products
  List<Product> _allProducts = [];
  List<Product> get allProducts => _allProducts;


  ///list of filterable products
  List<Product> _filterableProducts = [];
  List<Product> get filterableProducts => _filterableProducts;
  set filterableProducts(List<Product>  val){
    _filterableProducts = val;
    notifyListeners();
  }

  ///variable to retrieve last doc
  DocumentSnapshot? _lastDocument;
  DocumentSnapshot? get lastDocument => _lastDocument;
  set lastDocument(DocumentSnapshot? val){
    _lastDocument = val;
  }

  ///flag to check if there are more data to fetch from fireStore
  bool _hasMoreData = true;
  bool get hasMoreData => _hasMoreData;


  ///fetches products from fireStore
  fetchProducts() async {
    try {
      setState(ViewState.Busy);
      final querySnapshot = await ProductService.query.get();
      _lastDocument = querySnapshot.docs.last;
      _allProducts = querySnapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      _filterableProducts = List.of(_allProducts);
      setState(ViewState.Retrieved);
    } catch (e) {
      _message = e.toString();
      setState(ViewState.Error);
    }
  }


  ///fetches more products
  fetchMoreProducts() async {
    setMoreState(ViewState.Busy);
    try{
      final newQuery = ProductService.query.startAfterDocument(_lastDocument!);
      List<Product> _moreProducts = (await ParentService.getQuery(query: newQuery)).docs.map((doc) {
        final product = Product.fromMap(doc.data() as Map<String, dynamic>);
        _lastDocument = doc;
        return product;
      }).toList();
      _allProducts.addAll(_moreProducts);
      _filterableProducts.addAll(_moreProducts);
      _hasMoreData = _moreProducts.isNotEmpty;
      setMoreState(ViewState.Retrieved);
    }catch(e){
      _message = e.toString();
      setMoreState(ViewState.Error);
    }

  }

  ///fetch products by filters
  fetchFilteredProducts({required FilterViewModel filterVm}) async {
    setFilterState(ViewState.Busy);
    try{

      ///init filteredQuery from product service
      Query filteredQuery = ProductService.filteredQuery;

      /// Apply brand name filter if selected
      if (filterVm.selectedBrandIndex <= 5) {
        filteredQuery = filteredQuery.where('brandName', isEqualTo: filterVm.brandNames[filterVm.selectedBrandIndex]);
      }

      /// Apply price range filter(by default)
      filteredQuery = filteredQuery.where('price', isGreaterThanOrEqualTo: filterVm.divisions[filterVm.currentRangeValues.start.toInt()]);
      filteredQuery = filteredQuery.where('price', isLessThanOrEqualTo: filterVm.divisions[filterVm.currentRangeValues.end.toInt()]);


      /// Apply gender filter if selected
      if (filterVm.selectedGender.isNotEmpty) {
        filteredQuery = filteredQuery.where('gender', isEqualTo: filterVm.selectedGender);
      }

      /// Apply color filter if selected
      if (filterVm.selectedFilterColor.isNotEmpty) {
        filteredQuery = filteredQuery.where('colors', arrayContains: filterVm.selectedFilterColor);
      }

      /// Apply sorting without price filter
      switch (filterVm.selectedSortByOption.toLowerCase()) {
        case 'most recent':
          filteredQuery = filteredQuery.orderBy('createdDate', descending: true);
          break;
        case 'highest reviews':
          filteredQuery = filteredQuery.orderBy('totalReviews', descending: true);
          break;
        case 'highest price':
          filteredQuery = filteredQuery.orderBy('price', descending: true);
          break;
        case 'lowest price':
          filteredQuery = filteredQuery.orderBy('price', descending: false);
          break;
        default:
          break;
      }


      /// Execute the query
      QuerySnapshot querySnapshot = await ParentService.getQuery(query: filteredQuery);

      _filterableProducts = querySnapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      _message = _filterableProducts.isNotEmpty ? 'Products Fetched Successfully':'No Products matched your filter categories';
      setFilterState(ViewState.Retrieved);
    }catch(e){
      if(e.toString().contains('http')){
        ///show users human-readable message;
        _message = 'an error occurred, please try again';
      }else{
        _message = e.toString();
      }
      setFilterState(ViewState.Error);
    }

  }


  ///filters product list
  filterList({required String searchWord}) {

    if(searchWord.toLowerCase() == 'all'){
      _filterableProducts = _allProducts;
    }else{
      _filterableProducts = _allProducts
          .where((product) =>
          product.brandName!.toLowerCase().contains(searchWord.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  ///returns the total number of items available based on brand name
  int itemCount({required String brandName}){
    int _count = 0;
    _allProducts.forEach((product) {
      if(product.brandName!.toLowerCase() == brandName.toLowerCase())
        _count++;
    });
    return _count;
  }

  ///updates product fields
  updateProductFields({required ProductDetailsViewModel productDetailsViewModel, required String productId})async{

      Future.delayed(Duration(seconds: 2), ()async{
        final _docSnapshot = await ProductService.fetchSingleProduct(productId: productId);

        if (_docSnapshot.exists) {
          Map<String, dynamic> data = _docSnapshot.data() as Map<String, dynamic>;
          final _product = Product.fromJson(data);

          int _position = _filterableProducts.indexWhere((filteredProduct) => filteredProduct.id == _product.id);
          _filterableProducts[_position].averageRating = _product.averageRating;
          _filterableProducts[_position].totalReviews = _product.totalReviews;

          int _position2 = _allProducts.indexWhere((product) => product.id == _product.id);
          _allProducts[_position2].averageRating = _product.averageRating;
          _allProducts[_position2].totalReviews = _product.totalReviews;

          productDetailsViewModel.updateSelectedProductProperties(
              averageRating: _product.averageRating!,
              totalReviews: _product.totalReviews!
          );

          notifyListeners();


        }
      });
  }



}

final productVm = ChangeNotifierProvider<ProductViewModel>((ref){
  return ProductViewModel();
});