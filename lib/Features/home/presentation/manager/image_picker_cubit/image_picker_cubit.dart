import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerInitial());
  List<File> pickedImages = [];
  File? pickedImage;
  final firebasefirestore = FirebaseFirestore.instance;
  Future<void> pickImage() async {
    emit(ImagePickerLoading());
    try {
      final picker = ImagePicker();
      List<XFile>? imageData =
          await picker.pickMultiImage(maxWidth: 512, maxHeight: 512);

      if (imageData.isEmpty) {
        pickedImages.clear();
        emit(ImagePickerEmpty());
      } else {
        pickedImages.clear();
        for (var image in imageData) {
          pickedImages.add(File((image).path));
        }
        emit(ImagePickerSuccess());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> pickSingleImage() async {
    emit(ImagePickerLoading());
    final picker = ImagePicker();
    XFile? imageData = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 736,
      maxHeight: 736,
    );
    if (imageData != null) {
      pickedImage = File((imageData).path);
      emit(ImagePickerSuccess());
    } else {
      emit(ImagePickerEmpty());
    }
  }
}
