import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shoply_admin/Features/orders/data/userOrders_model.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());
  List<UserOrders> orders = [];
  final _firestore = FirebaseFirestore.instance.collection('userOrders');

  Future<void> loadOrders() async {
    emit(OrdersLoading());
    try {
      _firestore
          .orderBy(
            "dateOfOrder",
          )
          .snapshots()
          .listen((event) {
        orders.clear();
        List<UserOrders> tempOrders = [];
        for (var doc in event.docs) {
          tempOrders.add(UserOrders.fromJson(doc.data()));
        }
        orders = tempOrders.reversed.toList();
        emit(OrdersSuccess());
      });
    } on FirebaseException catch (e) {
      if (e.message != null) {
        emit(OrdersFailed(errMessage: e.toString()));
      } else {
        emit(OrdersFailed(errMessage: 'Some thing went wrong!'));
      }
    } catch (e) {
      emit(OrdersFailed(errMessage: e.toString()));
    }
  }
}
