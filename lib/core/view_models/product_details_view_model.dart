import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/models/product.dart';

class ProductDetailsViewModel extends ChangeNotifier{


  ///flags to use on the UI
  int get selectedColorIndex => _sampleColors.indexOf(_selectedColor);
  int get selectedSizeIndex => _sampleSneakerSizes.indexOf(_selectedSize);
  int get availableQuantity => _selectedProduct?.quantity ?? 1;

  ///selected product
  Product? _selectedProduct;
  Product get selectedProduct => _selectedProduct!;
  set selectedProduct(Product val){
    _selectedProduct = val;
    initProductProperties();
  }


  ///quantity text controller
  TextEditingController _quantityController = TextEditingController(text: '1');
  TextEditingController get quantityController => _quantityController;

  ///list of static sneaker types by brand
  List<String> _sampleSneakerPics = [];
  List<String> get sampleSneakerPics => _sampleSneakerPics;

  ///list of static sneaker types by brand
  List<String> _sampleSneakerSizes = [];
  List<String> get sampleSneakerSizes => _sampleSneakerSizes;

  ///list of static sample colors
  List<String> _sampleColors = [];
  List<String> get sampleColors => _sampleColors;
  
  ///selected color
  String _selectedColor ='';
  String get selectedColor => _selectedColor;

  ///selected size
  String _selectedSize ='';
  String get selectedSize => _selectedSize;


  ///index position of the slider on the product details screen
  int? _imageIndex = 0;
  int? get imageIndex => _imageIndex;

  ///list of static rating categories
  List<String> _ratingCategories = [
    'All',
    '5 Stars',
    '4 Stars',
    '3 Stars',
    '2 Stars',
    '1 Star'
  ];
  List<String> get ratingCategories => _ratingCategories;

  ///selected sneaker brand
  String _selectedRatingCategory = 'All';
  String get selectedRatingCategory => _selectedRatingCategory;
  set selectedRatingCategory(String val){
    _selectedRatingCategory = val;
    notifyListeners();
  }

  ///selected product quantity
  int _selectedQuantity = 1;
  int get selectedQuantity => _selectedQuantity;
  set selectedQuantity(int val){
    _selectedQuantity = val;
    notifyListeners();
  }


  ///initialize product properties
  initProductProperties(){
    _sampleSneakerPics = _selectedProduct?.productUrls ?? [];
    _sampleColors = _selectedProduct?.colors ?? [];
    _sampleSneakerSizes = _selectedProduct?.sizes ?? [];
  }

  ///increments selected quantity value
  incrementQuantity(){
    _selectedQuantity++;
    _quantityController.text = _selectedQuantity.toString();
    notifyListeners();
  }

  ///decrements selected quantity value
  decrementQuantity(){
    _selectedQuantity--;
    _quantityController.text = _selectedQuantity.toString();
    notifyListeners();
  }


  ///update the position index of home slider
  updateIndex({int? index}){
    _imageIndex = index;
    notifyListeners();
  }

  ///set selected color
  setSelectedColor({required int index}){
    _selectedColor = _sampleColors[index];
    notifyListeners();
  }

  ///set selected size
  setSelectedSize({required int index}){
    _selectedSize = _sampleSneakerSizes[index];
    notifyListeners();
  }

  ///set background color for color selection ball
  Color setColorBg({required int index}){
    switch(index){
      case 0:
        return ColorPath.codGrey;
      case 1:
        return Colors.white;
      case 2:
        return ColorPath.radicalRed;
      case 3:
        return ColorPath.juniperGreen;
      default:
        return ColorPath.ceruleanBlue;
    }
  }

  ///resets quantity values
  resetQuantity(){
    _selectedQuantity = 1;
    _quantityController.text = _selectedQuantity.toString();
  }

  ///called when a user inputs a quantity value in the text-field
  quantityOnChanged(String value){
    if(value.isEmpty){
      //_quantityController.text = '1';
      _selectedQuantity = 1;
    }else{
      _selectedQuantity = int.tryParse(value) ?? 1;
    }
    notifyListeners();
  }

  updateSelectedProductProperties({required String averageRating, required int totalReviews}){
    _selectedProduct!.averageRating = averageRating;
    _selectedProduct!.totalReviews = totalReviews;
    notifyListeners();
  }

}

final productDetailsVm = ChangeNotifierProvider.autoDispose<ProductDetailsViewModel>((ref){
  return ProductDetailsViewModel();
});