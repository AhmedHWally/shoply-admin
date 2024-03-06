part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsSuccess extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsFailure extends ProductsState {
  final String errMessage;
  ProductsFailure({required this.errMessage});
}
