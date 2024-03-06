part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersSuccess extends OrdersState {}

final class OrdersFailed extends OrdersState {
  final String errMessage;
  OrdersFailed({required this.errMessage});
}
