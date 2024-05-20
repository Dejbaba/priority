import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/utilities/auth_utils.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/core/view_models/cart_view_model.dart';
import 'package:priority_test/core/view_models/product_details_view_model.dart';
import 'package:priority_test/ui/widgets/bottom_sheets/add_to_cart_successful_bottom_sheet.dart';
import 'package:priority_test/ui/widgets/dock.dart';
import 'package:priority_test/ui/widgets/floating_flush_bar.dart';

class QuantitySelectorAndPricePreview extends StatelessWidget {

  final ValueChanged<bool> onChanged;


  const QuantitySelectorAndPricePreview({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final _productDetailsVm = ref.watch(productDetailsVm);
      final _cartVm = ref.watch(cartVm);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Quantity',
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            width: double.infinity,
            child: TextFormField(
                controller: _productDetailsVm.quantityController,
                style: GoogleFonts.urbanist(
                    fontSize: 14.sp, color: ColorPath.codGrey),
                onChanged: (value) =>
                    _productDetailsVm.quantityOnChanged(value),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorPath.codGrey)),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorPath.codGrey)),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: _productDetailsVm.selectedQuantity <= 1
                            ? null
                            : () {
                                _productDetailsVm.decrementQuantity();
                              },
                        child: SvgPicture.asset(
                          "assets/icons/minus.svg",
                          width: 24.w,
                          height: 24.h,
                          colorFilter: ColorFilter.mode(
                            _productDetailsVm.selectedQuantity <= 1
                                ? ColorPath.nobelGrey
                                : ColorPath.codGrey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      GestureDetector(
                        onTap: _productDetailsVm.selectedQuantity >= _productDetailsVm.availableQuantity
                            ? null
                            : () {
                                _productDetailsVm.incrementQuantity();
                              },
                        child: SvgPicture.asset(
                          "assets/icons/add.svg",
                          width: 24.w,
                          height: 24.h,
                          colorFilter: ColorFilter.mode(
                            _productDetailsVm.selectedQuantity >= _productDetailsVm.availableQuantity
                                ? ColorPath.nobelGrey
                                : ColorPath.codGrey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          SizedBox(
            height: 30.h,
          ),
          Dock(
            useBoxShadow: false,
            amount: double.tryParse(_productDetailsVm.selectedProduct.price.toString())! * _productDetailsVm.selectedQuantity,
            buttonText: 'ADD TO CART',
            onPressed: () async{
              popNavigation(context: context);
              onChanged(true);
              // await _cartVm.addToCart(
              //     productDetailsVm: _productDetailsVm
              // );
              // popNavigation(context: context);
              // ///add product to cart
              // addToCartSuccessfulBottomSheet(context: context, selectedQuantity: _productDetailsVm.selectedQuantity);
            },
          ),
        ],
      );
    });
  }
}
