// To parse this JSON data, do
//
//     final payNow = payNowFromJson(jsonString);

import 'dart:convert';

PayNow payNowFromJson(String str) => PayNow.fromJson(json.decode(str));

String payNowToJson(PayNow data) => json.encode(data.toJson());

class PayNow {
  PayNow({this.reference, this.amount, this.uen, this.formatAmount});

  String? reference;
  String? amount;
  String? uen;
  String? formatAmount;

  factory PayNow.fromJson(Map<String, dynamic> json) => PayNow(
        reference: json["reference"],
        amount: json["amount"],
        uen: json["uen"],
        formatAmount: json["format_amount"],
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
        "amount": amount,
        "uen": uen,
        "format_amount": formatAmount
      };
}
