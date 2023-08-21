import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoply_admin/Features/home/data/products_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  final _firestore = FirebaseFirestore.instance.collection('products');
  final List<Product> _productsList = [];
  List<Product> get productsList => [..._productsList].reversed.toList();
  Future<void> loadProducts() async {
    emit(ProductsLoading());
    try {
      _firestore.orderBy('dateOfUpload').snapshots().listen((event) {
        _productsList.clear();
        for (var doc in event.docs) {
          _productsList.add(Product.fromJson(doc.data()));
        }
        emit(ProductsSuccess());
      });
    } on FirebaseException catch (e) {
      if (e.message != null) {
        emit(ProductsFailure(errMessage: e.toString()));
      } else {
        emit(ProductsFailure(errMessage: 'Some thing went wrong!'));
      }
    } catch (e) {
      emit(ProductsFailure(errMessage: e.toString()));
    }
  }

  Future<void> removeItem(String id) async {
    await _firestore.doc(id).delete();
    emit(ProductsSuccess());
  }
}
