import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shoply_admin/Features/offers/data/offers_model.dart';
import 'package:shoply_admin/Features/products/presentation/manager/manage_products_cubit/manage_products_cubit.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial());
  final _firestore = FirebaseFirestore.instance.collection('offers');
  String? currentOfferId;
  List<Offers> offers = [];
  Future<void> uploadOffer(File? pickedImage) async {
    emit(UploadOfferLoading());
    if (pickedImage != null) {
      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('offers_images')
            .child(pickedImage.path.split('/').last);

        await ref.putFile(pickedImage);
        final url = await ref.getDownloadURL();
        DocumentReference docRef =
            await _firestore.add({"offerImageUrl": url, 'offerId': ''});
        final String docId = docRef.id;
        await _firestore.doc(docId).update({'offerId': docId});
        emit(UploadOfferSuccess());
      } catch (e) {}
    } else {
      emit(EmptyImage());
    }
  }

  Future<void> loadOffers() async {
    final firestore = FirebaseFirestore.instance.collection('offers');
    emit(OffersLoading());
    try {
      firestore.snapshots().listen((event) {
        offers.clear();
        for (var query in event.docs) {
          offers.add(Offers.fromJson(query.data()));
        }
        emit(OffersSuccess());
      });
    } on FirebaseException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeOffer(String offerId) async {
    final firestore = FirebaseFirestore.instance.collection('offers');
    try {
      await firestore.doc(offerId).delete();
      offers.removeWhere((element) => element.offerId == offerId);
      currentOfferId = null;
    } catch (e) {}
  }

  void confirmUpload() {
    emit(ConfirmUpload());
  }

  void confirmRemove() {
    emit(ConfirmRemove());
  }
}
