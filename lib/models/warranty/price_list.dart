import 'package:boilerplate/models/warranty/price.dart';

class WarrantyPriceList {
  final List<WarrantyPrice>? prices;

  WarrantyPriceList({
    this.prices,
  });

  factory WarrantyPriceList.fromJson(List<dynamic> json) {
    List<WarrantyPrice> prices = <WarrantyPrice>[];
    prices = json.map((make) => WarrantyPrice.fromJson(make)).toList();

    return WarrantyPriceList(
      prices: prices,
    );
  }
}
