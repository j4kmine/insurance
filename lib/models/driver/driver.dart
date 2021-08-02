import 'dart:convert';

List<Driver> driverListFromJson(String str) =>
    List<Driver>.from(json.decode(str).map((x) => Driver.fromJson(x)));

String driverListToJson(List<Driver> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Driver {
  Driver(
      {this.idType = "",
      this.idNumber = "",
      this.name = "",
      this.nationality = "",
      this.residential = "",
      this.gender = "",
      this.dateOfBirth = "",
      this.dateOfLicense = "",
      this.noOfAccidents = "",
      this.totalClaimAmount = "",
      this.formatIdType = "",
      this.formatResidential = "",
      this.formatNationality = "",
      this.formatDob = "",
      this.formatDol = ""});

  String idType;
  String idNumber;
  String name;
  String nationality;
  String residential;
  String gender;
  String dateOfBirth;
  String dateOfLicense;
  String noOfAccidents;
  String totalClaimAmount;
  String formatIdType;
  String formatResidential;
  String formatNationality;
  String formatDob;
  String formatDol;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
      idType: json["nric_type"],
      idNumber: json["nric"],
      name: json["name"],
      nationality: json["nationality"].toString(),
      residential: json["residential"].toString(),
      formatIdType: json["format_id_type"],
      formatResidential: json["format_residential"],
      formatNationality: json["format_nationality"],
      formatDob: json["format_dob"],
      formatDol: json["format_dol"],
      gender: json["gender"],
      dateOfBirth: json["dob"],
      dateOfLicense: json["license_pass_date"],
      noOfAccidents: json["no_of_accidents"].toString(),
      totalClaimAmount: json["total_claim"].toString());

  Map<String, dynamic> toJson() => {
        "nric_type": idType,
        "nric": idNumber,
        "name": name,
        "residential": residential,
        "nationality": nationality,
        "gender": gender,
        "dob": dateOfBirth,
        "license_pass_date": dateOfLicense,
        "no_of_accidents": noOfAccidents,
        "total_claim": totalClaimAmount
      };
}
