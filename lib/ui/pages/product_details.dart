import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/models/product.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/core/view_models/cart_view_model.dart';
import 'package:priority_test/core/view_models/order_view_model.dart';
import 'package:priority_test/core/view_models/product_details_view_model.dart';
import 'package:priority_test/core/view_models/product_view_model.dart';
import 'package:priority_test/core/view_models/reviews_view_model.dart';
import 'package:priority_test/core/view_models/wishlist_view_model.dart';
import 'package:priority_test/ui/pages/all_reviews.dart';
import 'package:priority_test/ui/widgets/bottom_sheets/add_review_bottom_sheet.dart';
import 'package:priority_test/ui/widgets/bottom_sheets/add_to_cart_bottom_sheet.dart';
import 'package:priority_test/ui/widgets/bottom_sheets/add_to_cart_successful_bottom_sheet.dart';
import 'package:priority_test/ui/widgets/busy_overlay.dart';
import 'package:priority_test/ui/widgets/cart_icon.dart';
import 'package:priority_test/ui/widgets/color_selection.dart';
import 'package:priority_test/ui/widgets/custom_appbar.dart';
import 'package:priority_test/ui/widgets/custom_dot.dart';
import 'package:priority_test/ui/widgets/dock.dart';
import 'package:priority_test/ui/widgets/error_state.dart';
import 'package:priority_test/ui/widgets/floating_flush_bar.dart';
import 'package:priority_test/ui/widgets/listview_items/product_slider_image.dart';
import 'package:priority_test/ui/widgets/listview_items/review_item.dart';
import 'package:priority_test/ui/widgets/size_selection.dart';
import 'package:priority_test/ui/widgets/wishlist_icon.dart';

class ProductDetails extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  @override
  void initState() {
    ref.read(productDetailsVm).selectedProduct = widget.product;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ///fetch product reviews
      ref.read(reviewVm).getReviewsByProductId(productId: widget.product.id!);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _productDetailsVm = ref.watch(productDetailsVm);
    final _reviewVm = ref.watch(reviewVm);
    final _cartVm = ref.watch(cartVm);
    final _wishlistVm = ref.watch(wishlistVm);
    final _productVm = ref.watch(productVm);
    return BusyOverlay(
      show: _cartVm.cartActionState == ViewState.Busy ||  _wishlistVm.wishlistActionState == ViewState.Busy || _reviewVm.reviewActionState == ViewState.Busy,
      child: Scaffold(
        appBar: CustomAppBar(
          actionIcons: [
            WishListIcon(),
            Padding(
              padding: EdgeInsets.only(right: 30.w),
              child: CartIcon(),
            )
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: ListView(
                    padding: EdgeInsets.only(
                        left: 30.w, right: 30.w, top: 10.h, bottom: 45.h),
                    children: [
                      ///slider image
                      productSliderImage(
                          context: context, productDetailsVm: _productDetailsVm),
                      SizedBox(
                        height: 30.h,
                      ),

                      ///product rating and reviews
                      productNameAndRatingSummary(
                          context: context, productDetailsVm: _productDetailsVm),
                      SizedBox(
                        height: 30.h,
                      ),

                      ///product size selector
                      productSizeSelector(
                          context: context, productDetailsVm: _productDetailsVm),
                      SizedBox(
                        height: 30.h,
                      ),

                      ///product description
                      productDescription(
                          context: context, productDetailsVm: _productDetailsVm),
                      SizedBox(
                        height: 30.h,
                      ),

                      ///product review list
                      productReviewList(
                          context: context,
                          productVm: _productVm,
                          productDetailsVm: _productDetailsVm,
                          reviewVm: _reviewVm)
                    ],
                  ),
                ),
              ),
              Dock(
                amount: double.tryParse(_productDetailsVm.selectedProduct.price.toString() ?? '0') ?? 0,
                buttonText: 'ADD TO CART',
                buttonHorizontalPadding: 31.5,
                onPressed: () {

                  if(_productDetailsVm.selectedColor.isEmpty){
                    ///prompt user to select a color
                    showFloatingFlushBar(
                      context: context,
                      message: "Kindly select a color to proceed",
                      duration: 2,
                      messageColor: Colors.white,
                    );
                    return;
                  }

                  if(_productDetailsVm.selectedSize.isEmpty){
                    ///prompt user to select a size
                    showFloatingFlushBar(
                      context: context,
                      message: "Kindly select a size to proceed",
                      duration: 2,
                      messageColor: Colors.white,
                    );
                    return;
                  }

                  _productDetailsVm.resetQuantity();

                  ///open add to cart bottom-sheet
                  addToCartBottomSheet(
                    context: context,
                    onChanged: (value)async{
                      if(value){
                        print('got here back to apply cart logic');
                        ///add to cart logic
                        await _cartVm.addToCart(
                            productDetailsVm: _productDetailsVm
                        );
                        if(_cartVm.cartActionState == ViewState.Retrieved){
                          print('addition successful');
                          ///show success bottom-sheet
                          addToCartSuccessfulBottomSheet(context: context, selectedQuantity: _productDetailsVm.selectedQuantity);
                        }
                        else{
                          showFloatingFlushBar(
                            context: context,
                            message: _cartVm.message!,
                            duration: 2,
                            messageColor: Colors.white,
                          );
                        }

                      }
                    }
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  ///dock

  ///product slider image
  productSliderImage(
          {required BuildContext context,
          required ProductDetailsViewModel productDetailsVm}) =>
      Container(
        child: Stack(
          children: [
            Container(
              height: 315.h, //350
              width: double.infinity,
              child: Swiper(
                autoplay: true,
                loop: true,
                itemCount: productDetailsVm.sampleSneakerPics.length,
                curve: Curves.linearToEaseOut,
                itemHeight: double.infinity,
                itemWidth: double.infinity,
                onIndexChanged: (index) =>
                    productDetailsVm.updateIndex(index: index),
                itemBuilder: (BuildContext context, int index) {
                  final _sneakerPic = productDetailsVm.sampleSneakerPics[index];
                  return ProductSliderImage(sneakerPic: _sneakerPic);
                },
              ),
            ),
            Positioned(
              top: 10.h,
              right: 10.h,
              child: Consumer(
                  builder: (context, ref, child){
                    final _wishlistVm = ref.watch(wishlistVm);
                    final _isExist = _wishlistVm.isProductInWishList(productId: productDetailsVm.selectedProduct.id!);
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
                          await _wishlistVm.deleteWishlist(productId: productDetailsVm.selectedProduct.id!);
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
                          await _wishlistVm.addToWishlist(product: productDetailsVm.selectedProduct);
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
                          width: 24.w,
                          height: 24.h,
                          colorFilter: ColorFilter.mode(
                            ColorPath.codGrey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 15.h,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 24.w, right: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            productDetailsVm.sampleSneakerPics.length,
                            (index) => CustomDot(
                                  isActive:
                                      productDetailsVm.imageIndex == index,
                                  activeColor: ColorPath.codGrey,
                                )),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.r))),
                        child: Row(
                          children: List.generate(
                              productDetailsVm.sampleColors.length,
                              (index) => ColorSelection(
                                    index: index,
                                    productDetailsVm: productDetailsVm,
                                  )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );

  ///product rating and review summary
  productNameAndRatingSummary(
          {required BuildContext context,
          required ProductDetailsViewModel productDetailsVm}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///product name
          Text(
            '${productDetailsVm.selectedProduct.productName}',
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: double.tryParse(
                        productDetailsVm.selectedProduct.averageRating ??
                            '0') ??
                    0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 12.h,
                itemPadding: EdgeInsets.symmetric(horizontal: 3.w),
                itemBuilder: (context, _) => SvgPicture.asset(
                  "assets/icons/star.svg",
                  width: 12.w,
                  height: 12.h,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                '${productDetailsVm.selectedProduct.averageRating}',
                style: GoogleFonts.urbanist(
                    color: ColorPath.codGrey,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                '(${productDetailsVm.selectedProduct.totalReviews} ${productDetailsVm.selectedProduct.totalReviews! > 1 ? 'Reviews':'Review'})',
                style: GoogleFonts.urbanist(
                    color: ColorPath.nobelGrey,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          )
        ],
      );

  ///product size selection
  productSizeSelector(
          {required BuildContext context,
          required ProductDetailsViewModel productDetailsVm}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Size',
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: List.generate(
                productDetailsVm.sampleSneakerSizes.length,
                (index) => SizeSelection(
                      index: index,
                      productDetailsVm: productDetailsVm,
                    )),
          )
        ],
      );

  ///product description
  productDescription(
          {required BuildContext context,
          required ProductDetailsViewModel productDetailsVm}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Engineered to crush any movement-based \nworkout, these On sneakers enhance the label's original Cloud sneaker with cutting edge technologies for a pair.",
            style: GoogleFonts.urbanist(
              color: ColorPath.doveGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.5.h,
            ),
          ),
        ],
      );

  ///product review list
  productReviewList(
          {required BuildContext context,
          required ProductDetailsViewModel productDetailsVm,
            required ProductViewModel productVm,
          required ReviewsViewModel reviewVm}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Review (${productDetailsVm.selectedProduct.totalReviews})',
                style: GoogleFonts.urbanist(
                    color: ColorPath.codGrey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
              Consumer(
                builder: (context, ref, child){
                  final _orderVm = ref.watch(orderVm);
                  final _canReviewProduct = _orderVm.isProductPurchased(productId: productDetailsVm.selectedProduct.id!);
                  if(_canReviewProduct)
                    return GestureDetector(
                      onTap: (){
                        reviewVm.clearInputs();
                        addReviewBottomSheet(context: context,
                            onChanged: (value)async{
                          if(value){
                            await reviewVm.submitReview(product: productDetailsVm.selectedProduct);
                            if(reviewVm.reviewActionState == ViewState.Retrieved){
                              ///display success prompt to user
                              showFloatingFlushBar(
                                context: context,
                                bgColor: Colors.green,
                                message: reviewVm.message!,
                                duration: 2,
                                messageColor: Colors.white,
                              );

                              ///update product properties
                              productVm.updateProductFields(
                                  productDetailsViewModel: productDetailsVm,
                                  productId: productDetailsVm.selectedProduct.id!
                              );
                            }
                            else{
                              ///display error message
                              showFloatingFlushBar(
                                context: context,
                                message: reviewVm.message!,
                                duration: 2,
                                messageColor: Colors.white,
                              );
                            }
                          }

                        });
                      },
                      child: Text(
                        'Review Product',
                        style: GoogleFonts.urbanist(
                            color: ColorPath.codGrey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    );

                  return Container();

                }
              ),
            ],
          ),

          SizedBox(
            height: 10.h,
          ),
          if (reviewVm.state == ViewState.Busy)
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 20.h, width: 20.w, child: CircularProgressIndicator()),
            )
          else if (reviewVm.state == ViewState.Retrieved)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: reviewVm.allReviews.length > 3 ? 3 : reviewVm.allReviews.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ReviewItem(review: reviewVm.allReviews[index],);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 25.h,
                    );
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ///nav user to all reviews screen
                      pushNavigation(context: context, widget: AllReviews());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      elevation: 0,
                      side: BorderSide(color: ColorPath.mercuryGrey),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Text(
                      'SEE ALL REVIEW',
                      style: GoogleFonts.urbanist(
                          color: ColorPath.codGrey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ), // Button's label
                  ),
                )
              ],
            )
          else if (reviewVm.state == ViewState.Error)
            Align(
              alignment: Alignment.center,
              child: ErrorState(
                message: reviewVm.message!,
                onPressed: ()=>reviewVm.getReviewsByProductId(productId: widget.product.id!),
              ),
            )
          else
            Container(),
        ],
      );
}
