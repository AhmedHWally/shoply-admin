import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoply_admin/Features/products/data/products_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  final _firestore = FirebaseFirestore.instance.collection('products');
  final List<Product> _productsList = [];
  //List<Product> get productsList => [..._productsList].reversed.toList();
  List<Product> _searchedProductsList = [];
  List<Product> get searchedProductsList =>
      [..._searchedProductsList].reversed.toList();
  Future<void> loadProducts() async {
    emit(ProductsLoading());
    try {
      _firestore.orderBy('dateOfUpload').snapshots().listen((event) {
        _productsList.clear();
        for (var doc in event.docs) {
          _productsList.add(Product.fromJson(doc.data()));
        }
        _searchedProductsList = _productsList;
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

  void searchProducts(String value) {
    value.trim() == "" ||
            _productsList
                .where((element) =>
                    element.title.contains(value.trim()) ||
                    element.category.contains(value.trim()))
                .toList()
                .isEmpty
        ? _searchedProductsList = _productsList
        : _searchedProductsList = _productsList
            .where((element) =>
                element.title.contains(value.trim()) ||
                element.category.contains(value.trim()))
            .toList();

    emit(ProductsSuccess());
  }
}
