import 'package:boilerplate/models/servicing/service.dart';

class ServiceList {
  final List<Service>? services;

  ServiceList({
    this.services,
  });

  factory ServiceList.fromJson(List<dynamic> json) {
    List<Service> services = <Service>[];
    services = json.map((make) => Service.fromJson(make)).toList();

    return ServiceList(
      services: services,
    );
  }
}
