import 'package:boilerplate/models/workshop/workshop.dart';

class WorkshopList {
  final List<Workshop>? workshops;

  WorkshopList({
    this.workshops,
  });

  factory WorkshopList.fromJson(List<dynamic> json) {
    List<Workshop> workshops = <Workshop>[];
    workshops = json.map((make) => Workshop.fromJson(make)).toList();

    return WorkshopList(
      workshops: workshops,
    );
  }
}
