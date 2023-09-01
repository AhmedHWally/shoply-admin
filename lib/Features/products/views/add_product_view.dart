import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/home/data/products_model.dart';
import 'package:shoply_admin/Features/products/manager/image_picker_cubit/image_picker_cubit.dart';
import 'package:shoply_admin/Features/products/manager/manage_products_cubit/manage_products_cubit.dart';
import 'package:shoply_admin/Features/products/views/widgets/add_product_viewbody.dart';
import 'package:shoply_admin/constants.dart';

class AddProductView extends StatelessWidget {
  const AddProductView(
      {super.key, required this.width, required this.height, this.product});
  final double width, height;
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ImagePickerCubit()),
          BlocProvider(create: (context) => ManageProductsCubit())
        ],
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
