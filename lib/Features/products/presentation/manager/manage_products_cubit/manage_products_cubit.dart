import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:shoply_admin/Features/products/data/products_model.dart';

part 'manage_products_state.dart';

class ManageProductsCubit extends Cubit<ManageProductsState> {
  ManageProductsCubit() : super(ManageProductsInitial());
  final _firestore = FirebaseFirestore.instance.collection('products');
  List<dynamic> urls = [];
  Future<void> uploadProduct(String title, String price, String about,
      String category, List<File> pickedImages) async {
    emit(ManageProductsLoading());
    try {
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
    } on FirebaseException catch (e) {
      if (e.message != null) {
        emit(ManageProductsFailed(message: e.toString()));
      } else {
        emit(ManageProductsFailed(message: 'Some thing went wrong!'));
      }
    } catch (e) {
      print(e);
      emit(ManageProductsFailed(message: 'Some thing went wrong!'));
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

        emit(UpdateProductsSuccess(updatedProduct: product));
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
        emit(UpdateProductsSuccess(
            updatedProduct: Product(
                title: titleChanged ? title : product.title,
                category: categoryChanged ? category : product.category,
                price: priceChanged ? num.parse(price) : product.price,
                description: aboutChanged ? about : product.description,
                imageUrl: product.imageUrl,
                id: product.id)));
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
        emit(UpdateProductsSuccess(
            updatedProduct: Product(
                title: titleChanged ? title : product.title,
                category: categoryChanged ? category : product.category,
                price: priceChanged ? num.parse(price) : product.price,
                description: aboutChanged ? about : product.description,
                imageUrl: urls,
                id: product.id)));
      }
    } on FirebaseException catch (e) {
      if (e.message != null) {
        emit(ManageProductsFailed(message: e.toString()));
      } else {
        emit(ManageProductsFailed(message: 'Some thing went wrong!'));
      }
    } catch (e) {
      emit(ManageProductsFailed(message: 'Some thing went wrong!'));
    }
  }

  void confirmRemove() {
    emit(ConfirmRemove());
  }

  void confirmAddOrUpdate(String type, {List<File>? images}) {
    if (type == 'add') {
      if (images!.isEmpty) {
        emit(ManageProductsFailedDuoToEmptyImage());
      } else {
        emit(ConfirmAddOrUpdate(type: type));
      }
    } else {
      emit(ConfirmAddOrUpdate(type: type));
    }
  }

  Future<void> removeItem(String id) async {
    try {
      await _firestore.doc(id).delete();
      emit(ItemRemoved());
    } on FirebaseException catch (e) {
      if (e.message != null) {
        emit(ManageProductsFailed(message: e.toString()));
      } else {
        emit(ManageProductsFailed(message: 'Some thing went wrong!'));
      }
    } catch (e) {
      emit(ManageProductsFailed(message: 'Some thing went wrong!'));
    }
  }
}
