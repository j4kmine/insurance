import 'package:boilerplate/models/servicing/service.dart';
import 'package:boilerplate/models/servicing/service_slot.dart';

class ServiceSlotList {
  final List<ServiceSlot>? serviceSlots;

  ServiceSlotList({
    this.serviceSlots,
  });

  factory ServiceSlotList.fromJson(List<dynamic> json) {
    List<ServiceSlot> serviceSlots = <ServiceSlot>[];
    serviceSlots = json.map((make) => ServiceSlot.fromJson(make)).toList();

    return ServiceSlotList(
      serviceSlots: serviceSlots,
    );
  }
}
