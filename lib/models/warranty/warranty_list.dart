import 'package:boilerplate/models/warranty/warranty.dart';

class WarrantyList {
  final List<Warranty>? warranties;

  WarrantyList({
    this.warranties,
  });

  factory WarrantyList.fromJson(List<dynamic> json) {
    List<Warranty> warranties = <Warranty>[];
    warranties = json.map((make) => Warranty.fromJson(make)).toList();

    return WarrantyList(
      warranties: warranties,
    );
  }
}
