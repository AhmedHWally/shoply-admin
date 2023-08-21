import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/Features/home/presentation/manager/image_picker_cubit/image_picker_cubit.dart';

import '../../../../../../constants.dart';

class PickImageRow extends StatelessWidget {
  const PickImageRow(
      {super.key,
      required this.width,
      required this.height,
      required this.imagesController,
      this.productImages});
  final double width, height;
  final PageController imagesController;
  final List<dynamic>? productImages;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      BlocBuilder<ImagePickerCubit, ImagePickerState>(
          builder: (context, state) {
        if (state is ImagePickerSuccess) {
          return Column(
            children: [
              Container(
                height: height * 0.2,
                width: width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kPrimaryColor)),
                child: PageView(
                    controller: imagesController,
                    children: BlocProvider.of<ImagePickerCubit>(context)
                        .pickedImages
                        .map((e) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      fit: BoxFit.fill, image: FileImage(e))),
                            ))
                        .toList()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        imagesController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: kPrimaryColor,
                      )),
                  IconButton(
                      onPressed: () {
                        imagesController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: kPrimaryColor,
                      ))
                ],
              )
            ],
          );
        } else if (state is ImagePickerLoading) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimaryColor),
          );
        } else {
          if (productImages == null) {
            return Container(
              height: height * 0.2,
              width: width * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: kPrimaryColor)),
            );
          } else {
            return Container(
                height: height * 0.2,
                width: width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kPrimaryColor)),
                child: PageView(
                    controller: imagesController,
                    children: (productImages as List<dynamic>)
                        .map((e) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: e,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                      color: kPrimaryColor),
                                ),
                                fit: BoxFit.cover,
                              ),
                            )))
                        .toList()));
          }
        }
      }),
      ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
          onPressed: () {
            BlocProvider.of<ImagePickerCubit>(context).pickImage();
          },
          child: const Text('pick image'))
    ]);
  }
}
