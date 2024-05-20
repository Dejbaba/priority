import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/models/product.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/core/utilities/utilities.dart';
import 'package:priority_test/core/view_models/wishlist_view_model.dart';
import 'package:priority_test/ui/pages/product_details.dart';
import 'package:priority_test/ui/widgets/floating_flush_bar.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushNavigation(context: context, widget: ProductDetails(
          product: product,
        ));
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                decoration: BoxDecoration(
                    color: ColorPath.mercuryGrey,
                    borderRadius: BorderRadius.all(Radius.circular(20.r))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          "${product.brandLogo}",
                          width: 24.w,
                          height: 24.h,
                          colorFilter: ColorFilter.mode(
                            ColorPath.nobelGrey,
                            BlendMode.srcIn,
                          ),
                        ),
                        Consumer(
                          builder: (context, ref, child){
                            final _wishlistVm = ref.watch(wishlistVm);
                            final _isExist = _wishlistVm.isProductInWishList(productId: product.id!);
                            return  AnimatedContainer(
                              duration: Duration(seconds: 1),
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: GestureDetector(
                                onTap: _isExist ? ()async{
                                  ///remove item from wishlist
                                  await _wishlistVm.deleteWishlist(productId: product.id!);
                                  if(_wishlistVm.wishlistActionState == ViewState.Retrieved){
                                    ///show success message
                                    showFloatingFlushBar(
                                      context: context,
                                      message: _wishlistVm.message!,
                                      bgColor: Colors.green,
                                      duration: 1,
                                      messageColor: Colors.white,
                                    );
                                  }
                                  else{
                                    ///show error message
                                    showFloatingFlushBar(
                                      context: context,
                                      message: _wishlistVm.message!,
                                      duration: 2,
                                      messageColor: Colors.white,
                                    );
                                  }
                                }
                                :()async{
                                  ///add item to wishlist
                                  await _wishlistVm.addToWishlist(product: product);
                                  if(_wishlistVm.wishlistActionState == ViewState.Retrieved){
                                    ///show success message
                                    showFloatingFlushBar(
                                      context: context,
                                      message: _wishlistVm.message!,
                                      bgColor: Colors.green,
                                      duration: 1,
                                      messageColor: Colors.white,
                                    );
                                  }
                                  else{
                                    ///show error message
                                    showFloatingFlushBar(
                                      context: context,
                                      message: _wishlistVm.message!,
                                      duration: 2,
                                      messageColor: Colors.white,
                                    );
                                  }
                                },
                                child: SvgPicture.asset(
                                  _isExist ? "assets/icons/wishlist_added.svg":"assets/icons/wishlist_removed.svg",
                                  width: 20.w,
                                  height: 20.h,
                                  colorFilter: ColorFilter.mode(
                                    ColorPath.codGrey,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            );
                          }
                        )],
                    ),
                    SizedBox(height: 20.h,),
                    Image.asset(
                      "${product.productUrls?[0]}",
                      width: 120.w,
                      height: 85.h,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            Text(
              '${product.productName}',
              style: GoogleFonts.urbanist(
                  color: ColorPath.codGrey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10.h,),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/star.svg",
                  width: 12.w,
                  height: 12.h,
                ),
                SizedBox(width: 5.w,),
                Text(
                  '${product.averageRating}',
                  style: GoogleFonts.urbanist(
                      color: ColorPath.codGrey,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(width: 5.w,),
                Text(
                  '(${product.totalReviews} ${product.totalReviews! > 1 ? 'Reviews':'Review'})',
                  style: GoogleFonts.urbanist(
                      color: ColorPath.nobelGrey,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400
                  ),
                ),

              ],
            ),
            SizedBox(height: 5.h,),
            Text(
              '\$${Utilities.formatAmount(amount: double.tryParse('${product.price ?? '0'}') ?? 0)}',
              style: GoogleFonts.urbanist(
                  color: ColorPath.codGrey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700
              ),
            ),
          ],
        ),
      ),
    );
  }
}
