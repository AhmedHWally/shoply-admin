part of 'manage_products_cubit.dart';

@immutable
sealed class ManageProductsState {}

final class ManageProductsInitial extends ManageProductsState {}

final class ManageProductsLoading extends ManageProductsState {}

final class ManageProductsSuccess extends ManageProductsState {}

final class UpdateProductsSuccess extends ManageProductsState {
  final Product updatedProduct;
  UpdateProductsSuccess({required this.updatedProduct});
}

final class ManageProductsFailed extends ManageProductsState {
  final String message;
  ManageProductsFailed({required this.message});
}

final class ManageProductsFailedDuoToEmptyImage extends ManageProductsState {}

final class ConfirmRemove extends ManageProductsState {}

final class ConfirmAddOrUpdate extends ManageProductsState {
  final String type;
  ConfirmAddOrUpdate({required this.type});
}

final class ItemRemoved extends ManageProductsState {}
