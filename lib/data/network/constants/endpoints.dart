import 'package:flutter/foundation.dart';

class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = kReleaseMode
      ? "https://partners.carfren.com.sg"
      : "https://dev.carfren.com.sg";
  // : "https://dev.carfren.com.sg";
  // static const String baseUrl = "https://partners.carfren.com.sg";

  // receiveTimeout
  static const int receiveTimeout = 20000;

  // connectTimeout
  static const int connectionTimeout = 20000;

  // endpoints
  static const String singpassSuccess = baseUrl + "/singpass/success";
  static const String images = baseUrl + "/images/vue/companies";
  static const String vehicles = baseUrl + "/api/mobile/vehicles";
  static const String vehicleSummary = baseUrl + "/api/mobile/vehicles/summary";

  static const String warranties = baseUrl + "/api/mobile/warranties";
  static const String warrantyEnquiry =
      baseUrl + "/api/mobile/warranties/enquiry";
  static const String warrantyBuy = baseUrl + "/api/mobile/warranties/buy";
  static const String warrantyMakes = baseUrl + "/api/mobile/prices/makes";
  static const String warrantyModels = baseUrl + "/api/mobile/prices/models";
  static const String warrantyPrices = baseUrl + "/api/mobile/prices";
  static const String warrantyPackages = baseUrl + "/api/mobile/packages";
  static const String warrantyCheckout =
      baseUrl + "/api/mobile/warranties/stripe";
  static const String warrantyPayNowRef =
      baseUrl + "/api/mobile/warranties/paynow-ref";
  static const String warrantyPayNow =
      baseUrl + "/api/mobile/warranties/paynow";

  static const String motors = baseUrl + "/api/mobile/motors";
  static const String motorMakes = baseUrl + "/api/mobile/motors/makes";
  static const String motorModels = baseUrl + "/api/mobile/motors/models";
  static const String motorSearchCar = baseUrl + "/api/mobile/motors/searchCar";
  static const String motorEnquiry = baseUrl + "/api/mobile/motors/enquiry";
  static const String motorCheckout = baseUrl + "/api/mobile/motors/stripe";
  static const String motorPayNowRef =
      baseUrl + "/api/mobile/motors/paynow-ref";
  static const String motorPayNow = baseUrl + "/api/mobile/motors/paynow";

  static const String services = baseUrl + "/api/mobile/services";
  static const String serviceSlots =
      baseUrl + "/api/mobile/companies/{company_id}/service-slots";
  static const String serviceTypes =
      baseUrl + "/api/mobile/companies/{company_id}/service-types";
  static const String workshops = baseUrl + "/api/mobile/workshops";

  static const String accidentVehicleInfo =
      baseUrl + "/api/mobile/reports/vehicleInfo";
  static const String accident = baseUrl + "/api/mobile/reports";

  static const String singpass = baseUrl + "/singpass";
  static const String myinfo = baseUrl + "/myinfo";
  static const String login = baseUrl + "/api/mobile/login";
  static const String register = baseUrl + "/api/mobile/register";
  static const String check = baseUrl + "/api/mobile/check";

  static const String profile = baseUrl + "/api/mobile/profiles";
  static const String updateProfile = baseUrl + "/api/mobile/profiles/update";

  static const String activities = baseUrl + "/api/mobile/activities";
  static const String notifications = baseUrl + "/api/mobile/notifications";

  static const String getTerms =
      "https://partners.carfren.com.sg/documents/terms.pdf";
  static const String getPrivacy =
      "https://partners.carfren.com.sg/documents/privacy.pdf";
}
