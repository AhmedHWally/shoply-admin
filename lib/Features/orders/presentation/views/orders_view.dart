import 'package:flutter/material.dart';
import 'package:shoply_admin/Features/orders/presentation/views/widgets/oders_view_body.dart';
import 'package:shoply_admin/Features/products/presentation/views/widgets/products_view_body.dart';

import '../../../../constants.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(kBackGroundImage), fit: BoxFit.fill),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: OrdersViewBody(),
      ),
    );
  }
}
