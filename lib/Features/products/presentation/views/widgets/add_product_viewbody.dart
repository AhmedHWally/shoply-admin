import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shoply_admin/Features/home/presentation/manager/image_picker_cubit/image_picker_cubit.dart';
import 'package:shoply_admin/Features/products/presentation/manager/manage_products_cubit/manage_products_cubit.dart';

import 'package:shoply_admin/Features/products/presentation/views/widgets/pick_image_row.dart';

import '../../../../../constants.dart';
import '../../../data/products_model.dart';
import 'custom_form_textfield.dart';

class AddProductViewBody extends StatelessWidget {
  AddProductViewBody(
      {super.key, required this.width, required this.height, this.product});
  final GlobalKey<FormState> _addProductFormKey = GlobalKey<FormState>();
  final PageController imagesController = PageController();
  final double width, height;
  final Product? product;
  @override
  Widget build(BuildContext context) {
    String? title, price, about, category;
    bool isLoading = false;
    return BlocConsumer<ManageProductsCubit, ManageProductsState>(
      listener: (context, state) {
        if (state is ManageProductsSuccess) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 2),
              content: Text('product uploaded succefully')));

          Future.delayed(
              const Duration(seconds: 2), () => Navigator.of(context).pop());
        } else if (state is UpdateProductsSuccess) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 2),
              content: Text('product updated succefully')));

          Future.delayed(
              const Duration(seconds: 2), () => Navigator.of(context).pop());
        } else if (state is ConfirmAddOrUpdate) {
          showAdaptiveDialog(
              context: context,
              builder: (ctx) => AlertDialog.adaptive(
                    content: state.type == 'add'
                        ? const Text(
                            'are you sure you want to upload this product to the database?')
                        : const Text(
                            'are you sure you want to update this product'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () {
                            if (state.type == 'add') {
                              Navigator.of(ctx).pop();
                              _addProductFormKey.currentState!.save();
                              BlocProvider.of<ManageProductsCubit>(context)
                                  .uploadProduct(
                                      title!,
                                      price!,
                                      about!,
                                      category!,
                                      BlocProvider.of<ImagePickerCubit>(context)
                                          .pickedImages);
                            } else if (state.type == 'update') {
                              Navigator.of(ctx).pop();
                              _addProductFormKey.currentState!.save();

                              BlocProvider.of<ManageProductsCubit>(context)
                                  .updateProduct(
                                      title!,
                                      price!,
                                      about!,
                                      category!,
                                      BlocProvider.of<ImagePickerCubit>(context)
                                          .pickedImages,
                                      product!);
                            }
                          },
                          child: const Text('yes'))
                    ],
                  ));
        } else if (state is ManageProductsLoading) {
          isLoading = true;
        } else if (state is ManageProductsFailed) {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is ManageProductsFailedDuoToEmptyImage) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('please pick a valid product image')));
        }
      },
      builder: (context, state) => SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: const CircularProgressIndicator(
            color: kPrimaryColor,
          ),
          opacity: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Row(children: [
                  CircleAvatar(
                    backgroundColor: Colors.black38,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )),
                  )
                ]),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Form(
                    key: _addProductFormKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        CustomFormTextFeild(
                          initalValue: product == null ? null : product!.title,
                          hintText:
                              product == null ? 'enter product title' : null,
                          textInputAction: TextInputAction.next,
                          onSaved: (enterdTitle) {
                            title = enterdTitle;
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomFormTextFeild(
                          initalValue:
                              product == null ? null : '${product!.price}',
                          hintText:
                              product == null ? 'enter product price' : null,
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onSaved: (enterdPrice) {
                            price = enterdPrice;
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomFormTextFeild(
                          initalValue:
                              product == null ? null : product!.description,
                          hintText: product == null
                              ? 'enter product discription'
                              : null,
                          maxLines: null,
                          onSaved: (enterdDescription) {
                            about = enterdDescription;
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomFormTextFeild(
                          initalValue:
                              product == null ? null : product!.category,
                          hintText:
                              product == null ? 'enter product category' : null,
                          textInputAction: TextInputAction.done,
                          onSaved: (enterdCategory) {
                            category = enterdCategory;
                            return null;
                          },
                        ),
                        Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.1),
                            child: BlocProvider.value(
                              value: BlocProvider.of<ImagePickerCubit>(context),
                              child: PickImageRow(
                                height: height,
                                width: width,
                                imagesController: imagesController,
                                productImages:
                                    product == null ? null : product!.imageUrl,
                              ),
                            ))
                      ],
                    )),
              )),
              SizedBox(
                height: height * 0.05,
                child: ElevatedButton(
                  onPressed: () async {
                    if (product == null) {
                      if (_addProductFormKey.currentState != null) {
                        if (_addProductFormKey.currentState!.validate()) {
                          BlocProvider.of<ManageProductsCubit>(context)
                              .confirmAddOrUpdate('add',
                                  images:
                                      BlocProvider.of<ImagePickerCubit>(context)
                                          .pickedImages);
                        }
                      }
                    } else {
                      if (_addProductFormKey.currentState != null) {
                        if (_addProductFormKey.currentState!.validate()) {
                          BlocProvider.of<ManageProductsCubit>(context)
                              .confirmAddOrUpdate(
                            'update',
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      splashFactory: NoSplash.splashFactory,
                      elevation: 0,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: product == null
                      ? const Text("Upload product")
                      : const Text("Update product"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
