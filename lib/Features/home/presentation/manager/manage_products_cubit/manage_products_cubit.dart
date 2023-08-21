import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../data/products_model.dart';

part 'manage_products_state.dart';

class ManageProductsCubit extends Cubit<ManageProductsState> {
  ManageProductsCubit() : super(ManageProductsInitial());
  final _firestore = FirebaseFirestore.instance.collection('products');
  List<dynamic> urls = [];
  Future<void> uploadProduct(String title, String price, String about,
      String category, List<File> pickedImages) async {
    emit(ManageProductsLoading());
    try {
      if (pickedImages.isEmpty) {
        emit(ManageProductsFailedDuoToEmptyImage());
      } else {
        urls.clear();
        for (var pickedImage in pickedImages) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('products_images')
              .child(pickedImage.path.split('/').last);

          await ref.putFile(pickedImage);
          final url = await ref.getDownloadURL();
          urls.add(url);
        }

        DocumentReference docRef = await _firestore.add(Product(
          title: title,
          id: '',
          category: category,
          price: num.parse(price),
          imageUrl: urls,
          description: about,
        ).toJson());

        final String docId = docRef.id;
        await _firestore.doc(docId).update({'id': docId});
        emit(ManageProductsSuccess());
      }
    } catch (e) {
      print(e);
      emit(ManageProductsFailed());
    }
  }

  Future<void> updateProduct(String title, String price, String about,
      String category, List<File> pickedImages, Product product) async {
    emit(ManageProductsLoading());
    try {
      bool titleChanged = title != product.title;
      bool aboutChanged = about != product.description;
      bool categoryChanged = category != product.category;
      bool priceChanged = price != product.price.toString();
      if (!titleChanged &&
          !aboutChanged &&
          !categoryChanged &&
          !priceChanged &&
          pickedImages.isEmpty) {
        // No fields have changed, no need to update
        emit(ManageProductsSuccess());
        return;
      }
      if (pickedImages.isEmpty) {
        Map<String, dynamic> updatedData = {
          if (titleChanged) 'title': title,
          if (aboutChanged) 'about': about,
          if (categoryChanged) 'category': category,
          if (priceChanged) 'price': num.parse(price),
          'dateOfUpload': DateTime.now()
        };
        await _firestore.doc(product.id).update(updatedData);
        emit(ManageProductsSuccess());
      } else {
        urls.clear();
        for (var pickedImage in pickedImages) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('products_images')
              .child(pickedImage.path.split('/').last);

          await ref.putFile(pickedImage);
          final url = await ref.getDownloadURL();
          urls.add(url);
        }
        Map<String, dynamic> updatedDataWithImages = {
          if (titleChanged) 'title': title,
          if (aboutChanged) 'about': about,
          if (categoryChanged) 'category': category,
          if (priceChanged) 'price': num.parse(price),
          'imageUrl': urls,
          'dateOfUpload': DateTime.now()
        };
        await _firestore.doc(product.id).update(updatedDataWithImages);
        emit(ManageProductsSuccess());
      }
    } catch (e) {
      print(e);
    }
  }
}
