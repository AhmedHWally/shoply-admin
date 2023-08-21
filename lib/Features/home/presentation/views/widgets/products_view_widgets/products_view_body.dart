import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/home/presentation/views/widgets/products_view_widgets/add_product_form.dart';
import 'package:shoply_admin/Features/home/presentation/views/widgets/products_view_widgets/products_grid_item.dart';

import 'package:shoply_admin/constants.dart';

import '../../../manager/products_cubit/products_cubit.dart';

class ProductsViewBody extends StatelessWidget {
  const ProductsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProductsSuccess) {
              return Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 2 / 2.5),
                      itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black),
                          ),
                          child: ProductsGridItem(
                              height: height,
                              width: width,
                              item: BlocProvider.of<ProductsCubit>(context)
                                  .productsList[index],
                              index: index)),
                      itemCount: BlocProvider.of<ProductsCubit>(context)
                          .productsList
                          .length,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: height * 0.05,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            splashFactory: NoSplash.splashFactory,
                            elevation: 0,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddProductForm(
                                    width: width,
                                    height: height,
                                  )));
                        },
                        child: const Text('Add Product')),
                  )
                ],
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: kPrimaryColor,
              ));
            }
          }),
    );
  }
}
