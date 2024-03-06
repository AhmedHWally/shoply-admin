import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/home/presentation/manager/image_picker_cubit/image_picker_cubit.dart';
import 'package:shoply_admin/Features/products/data/products_model.dart';

import 'package:shoply_admin/Features/products/presentation/views/widgets/add_product_viewbody.dart';
import 'package:shoply_admin/constants.dart';

class AddProductView extends StatelessWidget {
  const AddProductView(
      {super.key, required this.width, required this.height, this.product});
  final double width, height;
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ImagePickerCubit(),
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(kBackGroundImage), fit: BoxFit.fill),
            ),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: AddProductViewBody(
                  width: width,
                  height: height,
                  product: product,
                ))));
  }
}
