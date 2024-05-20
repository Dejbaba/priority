import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/view_models/wishlist_view_model.dart';
import 'package:priority_test/ui/widgets/busy_overlay.dart';
import 'package:priority_test/ui/widgets/custom_appbar.dart';
import 'package:priority_test/ui/widgets/empty_state.dart';
import 'package:priority_test/ui/widgets/error_state.dart';
import 'package:priority_test/ui/widgets/listview_items/wishlist_item.dart';

class Wishlist extends ConsumerStatefulWidget {
  const Wishlist({super.key});

  @override
  ConsumerState<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends ConsumerState<Wishlist> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ///fetch wishlists
      ref.read(wishlistVm).fetchWishlist();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BusyOverlay(
      show: ref.watch(wishlistVm).wishlistActionState == ViewState.Busy,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Wishlist',
        ),
        body: bodyContents(context: context, ref: ref),
      ),
    );
  }

  bodyContents({required BuildContext context, required WidgetRef ref}){

    final _wishlistVm = ref.watch(wishlistVm);


    if(_wishlistVm.state == ViewState.Busy){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(_wishlistVm.state == ViewState.Retrieved){
      if(_wishlistVm.wishListProducts.isEmpty){
        return Center(
          child: EmptyState(
            message: 'No Wishlist Found',
          ),
        );
      }
      return  SafeArea(
        bottom: false,
        child: GridView.builder(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _wishlistVm.wishListProducts.length,
            gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 32.h,
              crossAxisSpacing: 16.w,
              mainAxisExtent: 250.h,
            ),
            itemBuilder: (BuildContext context, int index) {
              final _wishListProduct = _wishlistVm.wishListProducts[index];
              return WishlistItem(
                product: _wishListProduct,
                wishlistVm: _wishlistVm,
              );
            }),
      );
    }

    if(_wishlistVm.state == ViewState.Error){
      return Center(
          child: ErrorState(
            message: _wishlistVm.message!,
            onPressed: () => _wishlistVm.fetchWishlist(),
          ));
    }

    return Container();


  }
}
