import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/products/manager/products_cubit/products_cubit.dart';
import 'package:shoply_admin/Features/products/views/add_product_view.dart';
import 'package:shoply_admin/Features/products/views/widgets/add_product_viewbody.dart';
import 'package:shoply_admin/Features/products/views/widgets/products_grid_item.dart';

import 'package:shoply_admin/constants.dart';

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
              return SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    CustomSearchButton(
                      height: height,
                    ),
                    const SizedBox(
                      height: 8,
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
                                    .searchedProductsList[index],
                                index: index)),
                        itemCount: BlocProvider.of<ProductsCubit>(context)
                            .searchedProductsList
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
                                builder: (context) => AddProductView(
                                      width: width,
                                      height: height,
                                    )));
                          },
                          child: const Text('Add Product')),
                    )
                  ],
                ),
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

class CustomSearchButton extends StatelessWidget {
  const CustomSearchButton({super.key, required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.075,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
          color: kSecondaryColor, borderRadius: BorderRadius.circular(32)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                  hintText: 'search',
                  hintStyle: TextStyle(color: Colors.white, shadows: [
                    Shadow(
                        color: kPrimaryColor,
                        offset: Offset(1, 1),
                        blurRadius: 1)
                  ]),
                  border: InputBorder.none),
              onChanged: (value) =>
                  BlocProvider.of<ProductsCubit>(context).searchProducts(value),
            ),
          ),
          const Icon(
            Icons.search,
            color: Colors.white,
            shadows: [
              Shadow(color: kPrimaryColor, blurRadius: 1, offset: Offset(1, 1))
            ],
          )
        ],
      ),
    );
  }
}
