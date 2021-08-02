// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String? str) => Customer.fromJson(json.decode(str!));

String? customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer(
      {this.id,
      this.nricType,
      this.salutation,
      this.name,
      this.gender,
      this.occupation,
      this.occupationType,
      this.nationality,
      this.residential,
      this.address,
      this.postalCode,
      this.email,
      this.phone,
      this.nricUen,
      this.dateOfBirth,
      this.emailVerifiedAt,
      this.status,
      this.profilePhoto,
      this.drivingLicenseClass,
      this.drivingLicenseValidity,
      this.stripeId,
      this.cardBrand,
      this.cardLastFour,
      this.createdAt,
      this.updatedAt,
      this.formatDob,
      this.formatNationality,
      this.formatResidential,
      this.formatDrivingLicenseValidity,
      this.formatOccupation});

  int? id;
  dynamic nricType;
  String? salutation;
  String? name;
  dynamic gender;
  dynamic occupation;
  dynamic occupationType;
  dynamic nationality;
  dynamic residential;
  dynamic address;
  dynamic postalCode;
  String? email;
  String? phone;
  String? nricUen;
  dynamic dateOfBirth;
  dynamic emailVerifiedAt;
  String? status;
  dynamic profilePhoto;
  dynamic drivingLicenseClass;
  dynamic drivingLicenseValidity;
  dynamic stripeId;
  dynamic cardBrand;
  dynamic cardLastFour;
  String? createdAt;
  DateTime? updatedAt;
  String? formatDob;
  String? formatNationality;
  String? formatResidential;
  String? formatDrivingLicenseValidity;
  String? formatOccupation;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        nricType: json["nric_type"],
        salutation: json["salutation"],
        name: json["name"],
        gender: json["gender"],
        occupation: json["occupation"],
        occupationType: json["occupation_type"],
        nationality: json["nationality"],
        residential: json["residential"],
        address: json["address"],
        postalCode: json["postal_code"],
        email: json["email"],
        phone: json["phone"],
        nricUen: json["nric_uen"],
        dateOfBirth: json["date_of_birth"],
        emailVerifiedAt: json["email_verified_at"],
        status: json["status"],
        profilePhoto: json["profile_photo"],
        drivingLicenseClass: json["driving_license_class"],
        drivingLicenseValidity: json["driving_license_validity"],
        stripeId: json["stripe_id"],
        cardBrand: json["card_brand"],
        cardLastFour: json["card_last_four"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        formatDrivingLicenseValidity: json["format_driving_license_validity"],
        formatDob: json["format_dob"],
        formatNationality: json["format_nationality"],
        formatResidential: json["format_residential"],
        formatOccupation: json["format_occupation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nric_type": nricType,
        "salutation": salutation,
        "name": name,
        "gender": gender,
        "occupation": occupation,
        "occupation_type": occupationType,
        "nationality": nationality,
        "residential": residential,
        "address": address,
        "postal_code": postalCode,
        "email": email,
        "phone": phone,
        "nric_uen": nricUen,
        "date_of_birth": dateOfBirth,
        "email_verified_at": emailVerifiedAt,
        "status": status,
        "profile_photo": profilePhoto,
        "driving_license_class": drivingLicenseClass,
        "driving_license_validity": drivingLicenseValidity,
        "stripe_id": stripeId,
        "card_brand": cardBrand,
        "card_last_four": cardLastFour,
        "created_at": createdAt,
        "updated_at": updatedAt!.toIso8601String(),
        "format_dob": formatDob,
        "format_nationality": formatNationality,
        "format_residential": formatResidential,
        "format_driving_license_validity": formatDrivingLicenseValidity,
        "format_occupation": formatOccupation
      };

  Map<String, dynamic> toProfileJson() => {
        'name': name,
        'gender': gender,
        'date_of_birth': formatDob,
        'nationality': formatNationality,
        'residential': formatResidential,
        'occupation': formatOccupation,
        'phone': phone!.replaceAll("+65 ", ""),
        'email': email,
        'address': address,
        'driving_license_class': drivingLicenseClass,
        'driving_license_validity': formatDrivingLicenseValidity,
      };
}
