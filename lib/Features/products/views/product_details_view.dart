import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/home/data/products_model.dart';
import 'package:shoply_admin/Features/products/manager/manage_products_cubit/manage_products_cubit.dart';
import 'package:shoply_admin/Features/products/views/widgets/product_details_viewbody.dart';

import 'package:shoply_admin/constants.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(kBackGroundImage), fit: BoxFit.fill)),
        child: BlocProvider(
          create: (context) => ManageProductsCubit(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ProductDetailsViewBody(product: product),
          ),
        ));
  }
}
