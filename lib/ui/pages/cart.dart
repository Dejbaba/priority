import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/utilities/auth_utils.dart';
import 'package:priority_test/core/utilities/navigator.dart';
import 'package:priority_test/core/view_models/cart_view_model.dart';
import 'package:priority_test/ui/pages/order_summary.dart';
import 'package:priority_test/ui/widgets/custom_appbar.dart';
import 'package:priority_test/ui/widgets/dock.dart';
import 'package:priority_test/ui/widgets/empty_state.dart';
import 'package:priority_test/ui/widgets/error_state.dart';
import 'package:priority_test/ui/widgets/listview_items/cart_item.dart';

class Cart extends ConsumerStatefulWidget {
  const Cart({super.key});

  @override
  ConsumerState<Cart> createState() => _CartState();
}

class _CartState extends ConsumerState<Cart> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ///fetch products
      ref.read(cartVm).fetchCartItems();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cart',
      ),
      body: bodyContents(context: context, ref: ref),
    );
  }

  bodyContents({required BuildContext context, required WidgetRef ref}){

    final _cartVm = ref.watch(cartVm);


    if(_cartVm.state == ViewState.Busy){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(_cartVm.state == ViewState.Retrieved){
      if(_cartVm.cartProducts.isEmpty){
        return Center(
          child: EmptyState(
            message: 'No Cart Found',
          ),
        );
      }
      return Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 30.h),
              itemCount: _cartVm.cartProducts.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final _cartItem = _cartVm.cartProducts[index];
                return CartItem(
                  cartProduct: _cartItem,
                  index: index,
                  cartVm: _cartVm,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 30.h,);
              },
            ),
          ),
          Dock(
            amount: _cartVm.subTotalPrice,
            buttonHorizontalPadding: 38.5,
            buttonText: 'CHECK OUT',
            label: 'Grand Total',
            onPressed: (){
              ///nav user to order summary screen
              pushNavigation(context: context, widget: OrderSummary());
            },
          )
        ],
      );
    }

    if(_cartVm.state == ViewState.Error){
      return Center(
          child: ErrorState(
            message: _cartVm.message!,
            onPressed: () => _cartVm.fetchCartItems(),
          ));
    }

    return Container();


  }
}
