import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/products/data/products_model.dart';
import 'package:shoply_admin/Features/products/presentation/manager/manage_products_cubit/manage_products_cubit.dart';

import 'package:shoply_admin/Features/products/presentation/views/add_product_view.dart';
import 'package:shoply_admin/Features/products/presentation/views/widgets/product_details_images.dart';
import 'package:shoply_admin/constants.dart';

class ProductDetailsViewBody extends StatelessWidget {
  ProductDetailsViewBody({super.key, required this.product});
  Product product;

  ElevatedButton elevatedButtonBuilder(
      BuildContext context, void Function()? onPressed, String title) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        onPressed: onPressed,
        child: Text(title));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BlocListener<ManageProductsCubit, ManageProductsState>(
        listener: (context, state) {
          if (state is ConfirmRemove) {
            showAdaptiveDialog(
                context: context,
                builder: (ctx) => AlertDialog.adaptive(
                      content: const Text(
                          'do you want to remove this product from the database'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text('No')),
                        TextButton(
                            onPressed: () {
                              BlocProvider.of<ManageProductsCubit>(context)
                                  .removeItem(product.id!);
                              Navigator.of(ctx).pop();
                            },
                            child: const Text('yes'))
                      ],
                    ));
          } else if (state is ItemRemoved) {
            Navigator.of(context).pop();
          } else if (state is UpdateProductsSuccess) {
            product = state.updatedProduct;
            print(product);
          } else if (state is ManageProductsFailed) {
            showAdaptiveDialog(
                context: context,
                builder: (ctx) => AlertDialog.adaptive(
                      content: const Text(
                          'some thing went wrong while removing the product please try again later'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text('ok'))
                      ],
                    ));
          }
        },
        child: BlocBuilder<ManageProductsCubit, ManageProductsState>(
            builder: (context, state) {
          print(state);
          print('rebuild');
          return Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                      width: width,
                      height: height * 0.375,
                      child: ProductImages(
                        product: product,
                      )),
                  Positioned(
                      left: 12,
                      top: 12,
                      child: CircleAvatar(
                        radius: width < 650 ? width / 16 : width / 24,
                        backgroundColor: Colors.white54,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ))
                ],
              ),
              const Divider(),
              Expanded(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      product.title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: SizedBox(
                        width: width,
                        child: Text(
                          product.description,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black87),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: SizedBox(
                        width: width,
                        child: Text(
                          'price: \$${product.price.toStringAsFixed(2)}',
                          textAlign: TextAlign.start,
                          style:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              )),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: width * 0.075,
                    right: width * 0.075,
                    bottom: height * 0.015),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: height * 0.05,
                        child: elevatedButtonBuilder(context, () {
                          BlocProvider.of<ManageProductsCubit>(context)
                              .confirmRemove();
                        }, 'remove'),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: height * 0.05,
                        child: elevatedButtonBuilder(context, () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddProductView(
                                    width: width,
                                    height: height,
                                    product: product,
                                  )));
                        }, 'edit'),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
