import 'package:flutter/material.dart';
import 'package:shoply_admin/Features/home/presentation/views/widgets/products_view_widgets/products_view_body.dart';

import '../../../../constants.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(kBackGroundImage), fit: BoxFit.fill),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: ProductsViewBody(),
      ),
    );
  }
}
