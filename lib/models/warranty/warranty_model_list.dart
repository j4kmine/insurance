import 'package:boilerplate/models/warranty/warranty_model.dart';

class WarrantyModelList {
  final List<WarrantyModel>? models;

  WarrantyModelList({
    this.models,
  });

  factory WarrantyModelList.fromJson(List<dynamic> json) {
    List<WarrantyModel> models = <WarrantyModel>[];
    models = json.map((make) => WarrantyModel.fromJson(make)).toList();

    return WarrantyModelList(
      models: models,
    );
  }
}
