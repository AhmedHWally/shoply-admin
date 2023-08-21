import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shoply_admin/Features/home/presentation/manager/image_picker_cubit/image_picker_cubit.dart';
import 'package:shoply_admin/Features/home/presentation/manager/manage_products_cubit/manage_products_cubit.dart';
import 'package:shoply_admin/Features/home/presentation/views/widgets/products_view_widgets/pick_image_row.dart';

import '../../../../../../constants.dart';
import '../../../../data/products_model.dart';
import 'custom_form_textfield.dart';

class AddProductForm extends StatelessWidget {
  AddProductForm(
      {super.key, required this.width, required this.height, this.product});
  final double width, height;
  final Product? product;
  final GlobalKey<FormState> _addProductFormKey = GlobalKey<FormState>();
  final PageController imagesController = PageController();
  @override
  Widget build(BuildContext context) {
    String? title, price, about, category;
    bool isLoading = false;

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
          body: BlocConsumer<ManageProductsCubit, ManageProductsState>(
            listener: (context, state) {
              if (state is ManageProductsSuccess) {
                isLoading = false;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('product uploaded succefully')));
                imagesController.dispose();
                Future.delayed(const Duration(seconds: 2),
                    () => Navigator.of(context).pop());
              } else if (state is ManageProductsLoading) {
                isLoading = true;
              } else if (state is ManageProductsFailed) {
                isLoading = false;
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('some thing went wrong')));
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
                    Expanded(
                        child: SingleChildScrollView(
                      child: Form(
                          key: _addProductFormKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              CustomFormTextFeild(
                                initalValue:
                                    product == null ? null : product!.title,
                                hintText: product == null
                                    ? 'enter product title'
                                    : null,
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
                                initalValue: product == null
                                    ? null
                                    : '${product!.price}',
                                hintText: product == null
                                    ? 'enter product price'
                                    : null,
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
                                initalValue: product == null
                                    ? null
                                    : product!.description,
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
                                hintText: product == null
                                    ? 'enter product category'
                                    : null,
                                textInputAction: TextInputAction.done,
                                onSaved: (enterdCategory) {
                                  category = enterdCategory;
                                  return null;
                                },
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.1),
                                  child: BlocProvider.value(
                                    value: BlocProvider.of<ImagePickerCubit>(
                                        context),
                                    child: PickImageRow(
                                      height: height,
                                      width: width,
                                      imagesController: imagesController,
                                      productImages: product == null
                                          ? null
                                          : product!.imageUrl,
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
                                _addProductFormKey.currentState!.save();
                                BlocProvider.of<ManageProductsCubit>(context)
                                    .uploadProduct(
                                        title!,
                                        price!,
                                        about!,
                                        category!,
                                        BlocProvider.of<ImagePickerCubit>(
                                                context)
                                            .pickedImages);
                              }
                            }
                          } else {
                            if (_addProductFormKey.currentState != null) {
                              if (_addProductFormKey.currentState!.validate()) {
                                _addProductFormKey.currentState!.save();
                                BlocProvider.of<ManageProductsCubit>(context)
                                    .updateProduct(
                                        title!,
                                        price!,
                                        about!,
                                        category!,
                                        BlocProvider.of<ImagePickerCubit>(
                                                context)
                                            .pickedImages,
                                        product!);
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
          ),
        ),
      ),
    );
  }
}
