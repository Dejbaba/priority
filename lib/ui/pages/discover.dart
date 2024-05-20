import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/utilities/auth_utils.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/core/view_models/cart_view_model.dart';
import 'package:priority_test/core/view_models/filter_view_model.dart';
import 'package:priority_test/core/view_models/order_view_model.dart';
import 'package:priority_test/core/view_models/product_view_model.dart';
import 'package:priority_test/core/view_models/wishlist_view_model.dart';
import 'package:priority_test/ui/pages/filter_screen.dart';
import 'package:priority_test/ui/widgets/busy_overlay.dart';
import 'package:priority_test/ui/widgets/cart_icon.dart';
import 'package:priority_test/ui/widgets/empty_state.dart';
import 'package:priority_test/ui/widgets/error_state.dart';
import 'package:priority_test/ui/widgets/listview_items/brand_name_item.dart';
import 'package:priority_test/ui/widgets/listview_items/product_item.dart';
import 'package:priority_test/ui/widgets/order_icon.dart';
import 'package:priority_test/ui/widgets/wishlist_icon.dart';

class Discover extends ConsumerStatefulWidget {
  const Discover({super.key});

  @override
  ConsumerState<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends ConsumerState<Discover> {
  late ScrollController _scrollController;

  @override
  void initState() {
    ///init user
    _initUserAndFetchData();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ///fetch products
      ref.read(productVm).fetchProducts();
    });
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_maxScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _initUserAndFetchData() async {
    await AuthUtils.initUser();
    Future.delayed(Duration(milliseconds: 100), () {
      ///fetch user carts
      ref.read(cartVm).fetchCartItems();

      ///fetch user wishlist
      ref.read(wishlistVm).fetchWishlist();

      ///fetch user orders
      ref.read(orderVm).fetchOrders();
    });
  }

  _maxScroll() async {
    final _productVm = ref.read(productVm);
    final _filterVm = ref.read(filterVm);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_productVm.state != ViewState.Busy &&
          _productVm.hasMoreData == true &&
          _filterVm.selectedSneakerBrand.toLowerCase() == 'all')
        _productVm.fetchMoreProducts();
    }
  }

  @override
  Widget build(BuildContext context) {

    return BusyOverlay(
      show: ref.watch(wishlistVm).wishlistActionState == ViewState.Busy,
      child: Scaffold(
        body: SafeArea(
            bottom: false, child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///title and cart icon
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discover',
                        style: GoogleFonts.urbanist(
                            color: ColorPath.codGrey,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          WishListIcon(),
                          if(ref.watch(orderVm).orders.isNotEmpty)
                          OrderIcon(),
                          CartIcon()
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                bodyContents(context: context, ref: ref)
              ],
            ),
            if (ref.watch(productVm).filterableProducts.isNotEmpty && ref.watch(productVm).state == ViewState.Retrieved)

            ///filter button
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 30.h),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      color: ColorPath.codGrey,
                      borderRadius: BorderRadius.all(Radius.circular(100.r))),
                  child: GestureDetector(
                    onTap: () {
                      ///nav user to filter screen
                      pushNavigation(context: context, widget: FilterScreen());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/filter.svg",
                          width: 20.w,
                          height: 20.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'FILTER',
                          style: GoogleFonts.urbanist(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        )),
      ),
    );
  }

  bodyContents({required BuildContext context, required WidgetRef ref}) {
    final _productVm = ref.watch(productVm);
    final _filterVm = ref.watch(filterVm);
    if (_productVm.state == ViewState.Busy) {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_productVm.state == ViewState.Retrieved) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///sneakers filter(by brand) options
            Container(
                height: 30.h,
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 30.w),
                  itemCount: _filterVm.sneakerBrands.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final _sneakerBrand = _filterVm.sneakerBrands[index];
                    return BrandNameItem(
                      sneakerBrand: _sneakerBrand,
                      filterVm: _filterVm,
                      productVm: _productVm,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 20.w,
                    );
                  },
                )),
            SizedBox(
              height: 30.h,
            ),
        
            if (_productVm.filterableProducts.isNotEmpty)
            ///product list
              Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(controller: _scrollController, children: [
                          GridView.builder(
                              padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 30.h),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _productVm.filterableProducts.length,
                              gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 32.h,
                                crossAxisSpacing: 16.w,
                                mainAxisExtent: 250.h,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return ProductItem(
                                  product: _productVm.filterableProducts[index],
                                );
                              })
                        ]),
                      ),
                      if (_productVm.moreState == ViewState.Busy)
                        Center(
                          child: SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: CircularProgressIndicator()),
                        ),
                      if (_productVm.moreState == ViewState.Error)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${_productVm.message}",
                              style: GoogleFonts.urbanist(
                                  color: ColorPath.codGrey,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            ElevatedButton(
                              onPressed: () => _productVm.fetchMoreProducts(),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 13.h, horizontal: 24.w),
                                elevation: 0,
                                backgroundColor: ColorPath.codGrey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                              ),
                              child: Text(
                                'Retry',
                                style: GoogleFonts.urbanist(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700),
                              ), // Button's label
                            ),
                          ],
                        )
                    ],
                  ))
            else
              Expanded(
                child: Center(
                    child: EmptyState(
                      message: 'Product Not Found',
                    )),
              ),
          ],
        ),
      );
    }

    if (_productVm.state == ViewState.Error) {
      ///error state
      return Expanded(
        child: Center(
            child: ErrorState(
          message: _productVm.message!,
          onPressed: () => _productVm.fetchProducts(),
        )),
      );
    }

    return Container();
  }
}
