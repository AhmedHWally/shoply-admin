import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../data/products_model.dart';

part 'manage_products_state.dart';

class ManageProductsCubit extends Cubit<ManageProductsState> {
  ManageProductsCubit() : super(ManageProductsInitial());
  final _firestore = FirebaseFirestore.instance.collection('products');
  Future<void> uploadProduct() async {
    emit(ManageProductsLoading());
    try {
      DocumentReference docRef = await _firestore.add(Product(
        title: 'test',
        id: '',
        category: 'shoes',
        price: 250,
        imageUrl: [
          'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/cec4b036-00b4-4c40-a40f-f3459b640fc6/revolution-6-mens-running-shoes-extra-wide-qP3nkM.png'
        ],
        description: 'good shoes',
      ).toJson());

      final String docId = docRef.id;
      await _firestore.doc(docId).update({'id': docId});
      emit(ManageProductsSuccess());
    } catch (e) {
      print(e);
      emit(ManageProductsFailed());
    }
  }
}
