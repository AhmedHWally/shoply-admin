import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/home/presentation/manager/products_cubit/products_cubit.dart';
import 'package:shoply_admin/Features/home/presentation/views/widgets/products_view_widgets/add_product_form.dart';

import '../../../../../../constants.dart';
import '../../../../../../core/widgets/custom_text_builder.dart';
import '../../../../data/products_model.dart';
import 'custom_grid_textbutton.dart';

class ProductsGridItem extends StatelessWidget {
  const ProductsGridItem(
      {super.key,
      required this.item,
      required this.index,
      required this.width,
      required this.height});
  final Product item;
  final int index;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: kSecondaryColor),
          child: Stack(
            children: [
              SizedBox(
                width: constrains.maxWidth,
                height: constrains.maxHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: item.imageUrl?[0],
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(color: kPrimaryColor),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => ProductDetails(
                  //           product: item,
                  //         )));
                  print('object');
                },
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    height: constrains.maxHeight * 0.3,
                    width: constrains.maxWidth,
                    decoration: const BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16))),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                child: CustomTextBuilder(
                                  title: item.title,
                                ),
                              ),
                              Expanded(
                                  child: CustomTextBuilder(
                                textAlign: TextAlign.center,
                                title: '\$ ${item.price.toStringAsFixed(2)}',
                                shadowColor: Colors.black26,
                                fontSize: 14,
                              ))
                            ],
                          )),
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                child: CustomTextButton(
                                    title: 'edit',
                                    color: Colors.pink,
                                    icon: Icons.edit,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddProductForm(
                                                    width: width,
                                                    height: height,
                                                    product: item,
                                                  )));
                                    }),
                              ),
                              Expanded(
                                  child: CustomTextButton(
                                title: 'remove',
                                icon: Icons.delete,
                                onPressed: () {
                                  BlocProvider.of<ProductsCubit>(context)
                                      .removeItem(item.id!);
                                },
                                color: Colors.purple,
                              ))
                            ],
                          ))
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ],
          )),
    );
  }
}
