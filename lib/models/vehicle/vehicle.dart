class Vehicle {
  Vehicle(
      {this.id,
      this.registrationNo,
      this.chassisNo,
      this.engineNo,
      this.make,
      this.model,
      this.mileage,
      this.capacity,
      this.category,
      this.seatingCapacity,
      this.bodyType,
      this.modificationRemarks,
      this.modified,
      this.offPeak,
      this.nricUen,
      this.type,
      this.fuel,
      this.manufactureYear,
      this.registrationDate,
      this.coeExpiryDate,
      this.taxExpiryDate,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.owned,
      this.formatRegistrationDate,
      this.warrantyValidity,
      this.motorValidity,
      this.formatCapacity,
      this.lastServicing});

  int? id;
  String? registrationNo;
  String? chassisNo;
  dynamic engineNo;
  String? make;
  String? model;
  int? mileage;
  dynamic capacity;
  dynamic category;
  dynamic seatingCapacity;
  dynamic bodyType;
  dynamic modificationRemarks;
  dynamic modified;
  dynamic offPeak;
  String? nricUen;
  dynamic type;
  dynamic fuel;
  dynamic manufactureYear;
  dynamic registrationDate;
  dynamic coeExpiryDate;
  dynamic taxExpiryDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? owned;
  String? formatRegistrationDate;
  String? formatCapacity;
  dynamic warrantyValidity;
  dynamic motorValidity;
  dynamic lastServicing;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        registrationNo: json["registration_no"],
        chassisNo: json["chassis_no"],
        engineNo: json["engine_no"],
        make: json["make"],
        model: json["model"],
        mileage: json["mileage"],
        capacity: json["capacity"],
        category: json["category"],
        seatingCapacity:
            json["seating_capacity"] == null ? '' : json["seating_capacity"],
        bodyType: json["body_type"],
        modificationRemarks: json["modification_remarks"],
        modified: json["modified"],
        offPeak: json["off_peak"],
        nricUen: json["nric_uen"],
        type: json["type"],
        fuel: json["fuel"],
        manufactureYear: json["manufacture_year"],
        registrationDate: json["registration_date"],
        coeExpiryDate: json["coe_expiry_date"],
        taxExpiryDate: json["tax_expiry_date"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        owned: json["owned"],
        formatRegistrationDate: json["format_registration_date"],
        warrantyValidity: json["warranty_validity"],
        formatCapacity: json["format_capacity"],
        motorValidity: json["motor_validity"],
        lastServicing: json["last_servicing"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "registration_no": registrationNo,
        "chassis_no": chassisNo,
        "engine_no": engineNo,
        "make": make,
        "model": model,
        "mileage": mileage,
        "capacity": capacity,
        "category": category,
        "seating_capacity": seatingCapacity,
        "body_type": bodyType,
        "modification_remarks": modificationRemarks,
        "modified": modified,
        "off_peak": offPeak,
        "nric_uen": nricUen,
        "type": type,
        "fuel": fuel,
        "manufacture_year": manufactureYear,
        "registration_date": registrationDate,
        "coe_expiry_date": coeExpiryDate,
        "tax_expiry_date": taxExpiryDate,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
        "owned": owned,
        "format_registration_date": formatRegistrationDate,
        "warranty_validity": warrantyValidity,
        "format_capacity": formatCapacity,
        "motor_validity": motorValidity,
        "last_servicing": lastServicing
      };
}
