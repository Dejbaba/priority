import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:priority_test/core/constants/color_path.dart';


class FilterViewModel extends ChangeNotifier{

  List<double> _divisions = [0.0, 200.0, 750.0, 1750.0];
  List<double> get divisions => _divisions;

  RangeValues _currentRangeValues = RangeValues(0, 3);
  RangeValues get currentRangeValues => _currentRangeValues;
  set currentRangeValues(RangeValues val){
    _currentRangeValues = val;
    notifyListeners();
  }

  ///list of active filter categories
  List<String> _filterCategories = ['price range'];
  List<String> get filterCategories => _filterCategories;

  ///list of static sneaker types by brand
  List<String> _sneakerBrands = [
    'All',
    'Nike',
    'Jordan',
    'Adidas',
    'Reebok',
    'Vans'
  ];
  List<String> get sneakerBrands => _sneakerBrands;

  ///selected sneaker brand
  String _selectedSneakerBrand = 'All';
  String get selectedSneakerBrand => _selectedSneakerBrand;
  set selectedSneakerBrand(String val){
    _selectedSneakerBrand = val;
    notifyListeners();
  }

  ///selected brand index(filter)
  int _selectedBrandIndex = 100000;
  int get selectedBrandIndex => _selectedBrandIndex;
  set selectedBrandIndex(int val){
    _selectedBrandIndex = val;
    increment(category: 'brand name');
    notifyListeners();
  }

  ///list of static brand logos
  List<String> _brandLogos = [
    'assets/images/brands/nike.svg',
    'assets/images/brands/puma.svg',
    'assets/images/brands/adidas.svg',
    'assets/images/brands/reebok.svg',
    'assets/images/brands/vans.svg',
    'assets/images/brands/jordan.svg',
  ];
  List<String> get brandLogos => _brandLogos;

  ///list of static brand names
  List<String> _brandNames = [
    'NIKE',
    'Puma',
    'Adidas',
    'Reebok',
    'Vans',
    'Jordan'
  ];
  List<String> get brandNames => _brandNames;

  ///list of sort by options
  List<String> _sortByOptions = [
    'Most Recent',
    'Lowest Price',
    'Highest Price',
    'Highest Reviews'
  ];
  List<String> get sortByOptions => _sortByOptions;

  ///selected sort by option
  String _selectedSortByOption = '';
  String get selectedSortByOption => _selectedSortByOption;
  set selectedSortByOption(String val){
    _selectedSortByOption = val;
    increment(category: 'sort by option');
    notifyListeners();
  }

  ///list of gender options
  List<String> _genders = [
    'Man',
    'Woman',
    'Unisex',
  ];
  List<String> get genders => _genders;

  ///selected sort by option
  String _selectedGender = '';
  String get selectedGender => _selectedGender;
  set selectedGender(String val){
    _selectedGender = val;
    increment(category: 'gender');
    notifyListeners();
  }

  ///list of static filter colors
  List<String> _filterColors = [
    'Black',
    'White',
    'Red',
  ];
  List<String> get filterColors => _filterColors;

  ///selected color
  String _selectedFilterColor ='';
  String get selectedFilterColor => _selectedFilterColor;
  set selectedFilterColor(String val){
    _selectedFilterColor = val;
    increment(category: 'color');
    notifyListeners();
  }


 

  ///set background color for color selection ball
  Color setFilterColorBg({required int index}){
    switch(index){
      case 0:
        return Colors.black;
      case 1:
        return Colors.transparent;
      case 2:
      default:
        return ColorPath.radicalRed;
    }
  }

  ///increments active filter categories count
  increment({
    required String category
  }){
    if(!_filterCategories.contains(category)){
      _filterCategories.add(category);
    }
  }

  reset({bool refreshUi = true}){
    _filterCategories = ['price range'];
    _selectedBrandIndex = 10000;
    _selectedSortByOption = '';
    _selectedGender = '';
    _selectedFilterColor = '';
    _currentRangeValues = RangeValues(0, 3);
    if(refreshUi)
      notifyListeners();
  }



}








final filterVm = ChangeNotifierProvider.autoDispose<FilterViewModel>((ref){
  return FilterViewModel();
});