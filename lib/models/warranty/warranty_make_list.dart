import 'package:boilerplate/models/warranty/warranty_make.dart';

class WarrantyMakeList {
  final List<WarrantyMake>? makes;

  WarrantyMakeList({
    this.makes,
  });

  factory WarrantyMakeList.fromJson(List<dynamic> json) {
    List<WarrantyMake> makes = <WarrantyMake>[];
    makes = json.map((make) => WarrantyMake.fromJson(make)).toList();

    return WarrantyMakeList(
      makes: makes,
    );
  }
}
