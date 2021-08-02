// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

Activity activityFromJson(String? str) => Activity.fromJson(json.decode(str!));

String? activityToJson(Activity data) => json.encode(data.toJson());

class Activity {
  Activity({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  Data? data;
  dynamic readAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        type: json["type"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        data: Data.fromJson(json["data"]),
        readAt: json["read_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "notifiable_type": notifiableType,
        "notifiable_id": notifiableId,
        "data": data!.toJson(),
        "read_at": readAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Data {
  Data({
    this.title,
    this.message,
    this.modelType,
    this.modelId,
  });

  String? title;
  String? message;
  String? modelType;
  int? modelId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        message: json["message"],
        modelType: json["model_type"],
        modelId: json["model_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "model_type": modelType,
        "model_id": modelId,
      };
}
