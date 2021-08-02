import 'package:boilerplate/models/customer/activity.dart';

class ActivityList {
  final List<Activity>? activities;

  ActivityList({
    this.activities,
  });

  factory ActivityList.fromJson(List<dynamic> json) {
    List<Activity> activities = <Activity>[];
    activities = json.map((activity) => Activity.fromJson(activity)).toList();

    return ActivityList(activities: activities);
  }
}
