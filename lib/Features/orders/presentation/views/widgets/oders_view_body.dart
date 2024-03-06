import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/orders/presentation/manager/orders_cubit/orders_cubit.dart';
import 'package:shoply_admin/Features/orders/presentation/views/widgets/order_item.dart';
import 'package:shoply_admin/constants.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
      if (state is OrdersSuccess) {
        return ListView.builder(
          itemBuilder: (context, index) => OrderItem(
              userOrder: BlocProvider.of<OrdersCubit>(context).orders[index]),
          itemCount: BlocProvider.of<OrdersCubit>(context).orders.length,
        );
      } else if (state is OrdersFailed) {
        return Center(
          child: Text(state.errMessage),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        );
      }
    }));
  }
}
