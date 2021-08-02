// To parse this JSON data, do
//
//     final access = accessFromJson(jsonString);

import 'dart:convert';

import 'package:boilerplate/models/customer/customer.dart';

Access accessFromJson(String str) => Access.fromJson(json.decode(str));

String accessToJson(Access data) => json.encode(data.toJson());

class Access {
  Access({
    this.owners,
    this.users,
  });

  List<Customer>? owners;
  List<Customer>? users;

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        owners: List<Customer>.from(
            json["owners"].map((x) => Customer.fromJson(x))),
        users:
            List<Customer>.from(json["users"].map((x) => Customer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "owners": List<dynamic>.from(owners!.map((x) => x.toJson())),
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}
