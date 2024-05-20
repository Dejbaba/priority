import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:priority_test/core/enums/view_state.dart';
import 'package:priority_test/core/view_models/order_view_model.dart';
import 'package:priority_test/ui/widgets/custom_appbar.dart';
import 'package:priority_test/ui/widgets/empty_state.dart';
import 'package:priority_test/ui/widgets/error_state.dart';
import 'package:priority_test/ui/widgets/listview_items/order_item.dart';

class Orders extends ConsumerStatefulWidget {
  const Orders({super.key});

  @override
  ConsumerState<Orders> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ///fetch orders
      ref.read(orderVm).fetchOrders();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Orders',
      ),
      body: bodyContents(context: context, ref: ref),
    );
  }

  bodyContents({required BuildContext context, required WidgetRef ref}){

    final _orderVm = ref.watch(orderVm);


    if(_orderVm.state == ViewState.Busy){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(_orderVm.state == ViewState.Retrieved){
      if(_orderVm.orders.isEmpty){
        return Center(
          child: EmptyState(
            message: 'No Order Found',
          ),
        );
      }
      return SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 30.h),
                itemCount: _orderVm.orders.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final _order = _orderVm.orders[index];
                  return OrderItem(order: _order);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 30.h,);
                },
              ),
            ),
          ],
        ),
      );
    }

    if(_orderVm.state == ViewState.Error){
      return Center(
          child: ErrorState(
            message: _orderVm.message!,
            onPressed: () => _orderVm.fetchOrders(),
          ));
    }

    return Container();


  }
}
