part of 'manage_products_cubit.dart';

@immutable
sealed class ManageProductsState {}

final class ManageProductsInitial extends ManageProductsState {}

final class ManageProductsLoading extends ManageProductsState {}

final class ManageProductsSuccess extends ManageProductsState {}

final class ManageProductsFailed extends ManageProductsState {}

final class ManageProductsFailedDuoToEmptyImage extends ManageProductsState {}
