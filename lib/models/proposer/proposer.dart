class Proposer {
  Proposer({
    this.id,
    this.nricType,
    this.salutation,
    this.name,
    this.gender,
    this.occupation,
    this.nationality,
    this.residential,
    this.address,
    this.postalCode,
    this.email,
    this.phone,
    this.nricUen,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
    this.formatResidential,
    this.formatNationality,
    this.formatOccupation,
    this.formatDob,
    this.formatDol,
  });

  int? id;
  dynamic nricType;
  String? salutation;
  String? name;
  dynamic gender;
  dynamic occupation;
  dynamic nationality;
  dynamic residential;
  String? address;
  dynamic postalCode;
  String? email;
  String? phone;
  String? nricUen;
  dynamic dateOfBirth;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? formatResidential;
  String? formatNationality;
  String? formatOccupation;
  String? formatDob;
  String? formatDol;

  factory Proposer.fromJson(Map<String, dynamic> json) => Proposer(
        id: json["id"],
        nricType: json["nric_type"],
        salutation: json["salutation"],
        name: json["name"],
        gender: json["gender"],
        occupation: json["occupation"],
        nationality: json["nationality"],
        residential: json["residential"],
        address: json["address"],
        postalCode: json["postal_code"],
        email: json["email"],
        phone: json["phone"],
        nricUen: json["nric_uen"],
        dateOfBirth: json["date_of_birth"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        formatResidential: json["format_residential"],
        formatNationality: json["format_nationality"],
        formatOccupation: json["format_occupation"],
        formatDob: json["format_dob"],
        formatDol: json["format_dol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nric_type": nricType,
        "salutation": salutation,
        "name": name,
        "gender": gender,
        "occupation": occupation,
        "nationality": nationality,
        "residential": residential,
        "address": address,
        "postal_code": postalCode,
        "email": email,
        "phone": phone,
        "nric_uen": nricUen,
        "date_of_birth": dateOfBirth,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "format_residential": formatResidential,
        "format_nationality": formatNationality,
        "format_occupation": formatOccupation,
        "format_dob": formatDob,
        "format_dol": formatDol,
      };
}
