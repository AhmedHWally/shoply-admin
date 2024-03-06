import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shoply_admin/Features/home/presentation/manager/image_picker_cubit/image_picker_cubit.dart';
import 'package:shoply_admin/Features/offers/presentation/manager/offers_cubit/offers_cubit.dart';
import 'package:shoply_admin/constants.dart';

class AddOfferPageViewBody extends StatelessWidget {
  AddOfferPageViewBody({super.key});
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: BlocListener<OffersCubit, OffersState>(
      listener: (context, state) {
        if (state is EmptyImage) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("please pick an image")));
          isLoading = false;
        } else if (state is ConfirmUpload) {
          showAdaptiveDialog(
              context: context,
              builder: (ctx) => AlertDialog.adaptive(
                    content: const Text("Upload offer?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("No")),
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<OffersCubit>(context).uploadOffer(
                                BlocProvider.of<ImagePickerCubit>(context)
                                    .pickedImage);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("Yes"))
                    ],
                  ));
        } else if (state is UploadOfferSuccess) {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Offer uploaded")));
          Navigator.of(context).pop();
        } else if (state is UploadOfferLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      child: BlocBuilder<OffersCubit, OffersState>(
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator:
              const CircularProgressIndicator(color: kPrimaryColor),
          opacity: 0,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BlocBuilder<ImagePickerCubit, ImagePickerState>(
                      builder: (context, state) {
                    if (state is ImagePickerLoading) {
                      return Container(
                        height: height * 0.3,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(16)),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is ImagePickerSuccess) {
                      return Container(
                          height: height * 0.3,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image: FileImage(
                                  BlocProvider.of<ImagePickerCubit>(context)
                                      .pickedImage!,
                                ),
                                fit: BoxFit.fill),
                          ));
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(16)),
                        height: height * 0.3,
                        width: width * 0.9,
                      );
                    }
                  }),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: () {
                        BlocProvider.of<ImagePickerCubit>(context)
                            .pickSingleImage();
                      },
                      child: const Text("Pick offer"))
                ],
              ),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: () {},
                      child: const Text('Go back')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: () {
                        BlocProvider.of<OffersCubit>(context).confirmUpload();
                      },
                      child: const Text('Upload Offer'))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
