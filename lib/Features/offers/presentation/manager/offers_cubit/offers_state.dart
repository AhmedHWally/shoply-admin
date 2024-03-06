part of 'offers_cubit.dart';

@immutable
sealed class OffersState {}

final class OffersInitial extends OffersState {}

final class OffersLoading extends OffersState {}

final class OffersSuccess extends OffersState {}

final class OffersFailed extends OffersState {}

final class UploadOfferLoading extends OffersState {}

final class UploadOfferSuccess extends OffersState {}

final class UploadOfferFailed extends OffersState {}

final class EmptyImage extends OffersState {}

final class ConfirmUpload extends OffersState {}

final class ConfirmRemove extends OffersState {}
