import 'package:boilerplate/models/warranty/package.dart';

class WarrantyPackageList {
  final List<WarrantyPackage>? packages;

  WarrantyPackageList({
    this.packages,
  });

  factory WarrantyPackageList.fromJson(List<dynamic> json) {
    List<WarrantyPackage> packages = <WarrantyPackage>[];
    packages = json.map((make) => WarrantyPackage.fromJson(make)).toList();

    return WarrantyPackageList(
      packages: packages,
    );
  }
}
