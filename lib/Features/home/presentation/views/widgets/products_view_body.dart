import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shoply_admin/Features/home/presentation/manager/manage_products_cubit/manage_products_cubit.dart';
import 'package:shoply_admin/Features/home/presentation/views/widgets/add_product_form.dart';

import 'package:shoply_admin/constants.dart';

import '../../manager/products_cubit/products_cubit.dart';

class ProductsViewBody extends StatelessWidget {
  const ProductsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProductsSuccess) {
              return Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          children: [
                            Text(DateFormat.yMMMMd().format(
                                BlocProvider.of<ProductsCubit>(context)
                                    .productsList[index]
                                    .dateOfUpload!)),
                            Text(
                                '${BlocProvider.of<ProductsCubit>(context).productsList[index].price}'),
                            Text(BlocProvider.of<ProductsCubit>(context)
                                .productsList[index]
                                .id)
                          ],
                        ),
                      ),
                      itemCount: BlocProvider.of<ProductsCubit>(context)
                          .productsList
                          .length,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddProductForm()));
                      },
                      child: const Text('test add'))
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
