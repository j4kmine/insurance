import 'package:boilerplate/models/servicing/service_type.dart';

class ServiceTypeList {
  final List<ServiceType>? serviceTypes;

  ServiceTypeList({
    this.serviceTypes,
  });

  factory ServiceTypeList.fromJson(List<dynamic> json) {
    List<ServiceType> serviceTypes = <ServiceType>[];
    serviceTypes = json.map((make) => ServiceType.fromJson(make)).toList();

    return ServiceTypeList(
      serviceTypes: serviceTypes,
    );
  }
}
