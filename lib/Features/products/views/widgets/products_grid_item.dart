import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoply_admin/Features/products/views/product_details_view.dart';
import '../../../../constants.dart';
import '../../../../core/widgets/custom_text_builder.dart';
import '../../../home/data/products_model.dart';

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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetailsView(
                            product: item,
                          )));
                },
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    height: constrains.maxHeight * 0.25,
                    width: constrains.maxWidth,
                    decoration: const BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomTextBuilder(
                              title: item.title,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: CustomTextBuilder(
                                textAlign: TextAlign.center,
                                title: '\$ ${item.price.toStringAsFixed(2)}',
                                shadowColor: Colors.black26,
                                fontSize: 14,
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
