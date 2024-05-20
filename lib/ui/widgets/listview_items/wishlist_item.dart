import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:priority_test/ui/widgets/confirmation_dialog.dart';
import 'package:priority_test/ui/widgets/floating_flush_bar.dart';

class WishlistItem extends StatelessWidget {
  final Product product;
  final WishlistViewModel wishlistVm;
  const WishlistItem({super.key, required this.product, required this.wishlistVm});

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
                        GestureDetector(
                          onTap: ()async{
                            final _delete = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return confirmationDialog(
                                      context: context,
                                      message: 'Are you sure you want to delete this item from your wishlist?'
                                  );
                                });

                            if(_delete == null || !_delete)
                              return;

                            await wishlistVm.deleteWishlist(productId: product.id!);
                            if(wishlistVm.wishlistActionState == ViewState.Retrieved){
                              ///show success message
                              showFloatingFlushBar(
                                context: context,
                                message: wishlistVm.message!,
                                bgColor: Colors.green,
                                duration: 1,
                                messageColor: Colors.white,
                              );
                            }
                            else{
                              ///show error message
                              showFloatingFlushBar(
                                context: context,
                                message: wishlistVm.message!,
                                duration: 2,
                                messageColor: Colors.white,
                              );
                            }



                          },
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/delete.svg",
                              width: 20.w,
                              height: 20.h,
                              colorFilter: ColorFilter.mode(
                                ColorPath.codGrey,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ],
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
