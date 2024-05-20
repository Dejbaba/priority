import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/models/cart_product.dart';
import 'package:priority_test/core/utilities/auth_utils.dart';
import 'package:priority_test/core/utilities/utilities.dart';
import 'package:priority_test/core/view_models/cart_view_model.dart';
import 'package:priority_test/ui/widgets/cart_counter.dart';
import 'package:priority_test/ui/widgets/confirmation_dialog.dart';
import 'package:priority_test/ui/widgets/floating_flush_bar.dart';

class CartItem extends StatelessWidget {
  final CartProduct cartProduct;
  final CartViewModel cartVm;
  final int index;
  const CartItem({super.key, required this.cartVm, required this.cartProduct, required this.index});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartProduct.id!),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async{
        print('i was called>>>');
        await cartVm.deleteCart(cartId: cartProduct.id!, index: index);
        if(cartVm.cartActionState == ViewState.Retrieved){
          ///display success prompt to user
          showFloatingFlushBar(
            context: context,
            bgColor: Colors.green,
            message: cartVm.message!,
            duration: 2,
            messageColor: Colors.white,
          );
        }
        else{
          ///display error message
          showFloatingFlushBar(
            context: context,
            message: cartVm.message!,
            duration: 2,
            messageColor: Colors.white,
          );
        }

      },
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return confirmationDialog(
                  context: context,
              );
            });
      },
      background: Container(
        padding: EdgeInsets.only(right: 28.w, top: 32.h, bottom: 32.h),
        decoration: BoxDecoration(
          color: ColorPath.radicalRed,
          borderRadius: BorderRadius.all(Radius.circular(20.r))
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: SvgPicture.asset(
            "assets/icons/delete.svg",
            width: 24.w,
            height: 24.h,
          ),
        ),
      ),
      child: Container(
        height: 88.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 88.h,
              width: 88.w,
              padding: EdgeInsets.only(left: 8.w, top: 19.h, bottom: 19.42.h, right: 10.w),
              decoration: BoxDecoration(
                  color: ColorPath.mercuryGrey,
                  borderRadius: BorderRadius.all(Radius.circular(20.r))
              ),
              child: Image.asset(
                "${cartProduct.url}",
                width: 70.w,
                height: 49.58.h,
              ),
            ),
            SizedBox(width: 15.w,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${cartProduct.productName}',
                        style: GoogleFonts.urbanist(
                            color: ColorPath.codGrey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Text(
                        '${cartProduct.brandName} . ${cartProduct.color} . ${cartProduct.size}',
                        style: GoogleFonts.urbanist(
                            color: ColorPath.doveGrey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '\$${Utilities.formatAmount(amount: double.tryParse('${cartProduct.price.toString() ?? '0'}'))}',
                        style: GoogleFonts.urbanist(
                            color: ColorPath.codGrey,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(width: 20.w,),
                      CartCounter(
                        lowerLimit: 1,
                        upperLimit: cartProduct.availableQuantity, ///quantity value of product
                        stepValue: 1,
                        value: cartProduct.quantity, ///quantity added to cart
                        onChanged: (value)async{
                          print('value returned: $value>>>>');
                          ///update cart in fireStore
                          await cartVm.updateCart(
                              cartItemId: cartProduct.id!,
                              newQuantity: value,
                              index: index);
                          if(cartVm.cartActionState == ViewState.Retrieved){
                            ///show success message
                            showFloatingFlushBar(
                              context: context,
                              message: cartVm.message!,
                              bgColor: Colors.green,
                              duration: 1,
                              messageColor: Colors.white,
                            );
                          }else{
                            ///show success message
                            showFloatingFlushBar(
                              context: context,
                              message: cartVm.message!,
                              duration: 2,
                              messageColor: Colors.white,
                            );
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
