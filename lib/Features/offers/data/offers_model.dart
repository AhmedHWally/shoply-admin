class Offers {
  final String offerId;
  final String offerImageUrl;
  Offers({required this.offerId, required this.offerImageUrl});
  factory Offers.fromJson(json) =>
      Offers(offerId: json["offerId"], offerImageUrl: json["offerImageUrl"]);
}
