import 'package:boilerplate/models/accident/vehicle_info.dart';

class VehicleInfoList {
  final List<VehicleInfo>? vehicleInfo;

  VehicleInfoList({
    this.vehicleInfo,
  });

  factory VehicleInfoList.fromJson(List<dynamic> json) {
    List<VehicleInfo> vehicleInfo = <VehicleInfo>[];
    vehicleInfo = json.map((post) => VehicleInfo.fromJson(post)).toList();

    return VehicleInfoList(
      vehicleInfo: vehicleInfo,
    );
  }
}
