import 'dart:convert';

import 'package:dio/dio.dart';

class DioErrorUtil {
  // general methods:------------------------------------------------------------
  static String handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription =
              "Received invalid status code: ${error.response?.statusCode}";
          if (error.response?.statusCode == 422) {
            var msg = error.response.toString();
            if (msg.contains("[") && msg.contains("]")) {
              var array =
                  msg.replaceAll("[", "").replaceAll("]", "").split(", ");
              for (int i = 0; i < array.length; i++) {
                if (i == 0) {
                  errorDescription = array[i];
                } else {
                  errorDescription += "\n" + array[i];
                }
              }
            } else {
              var array = json.decode(msg);
              errorDescription = array['message'];
            }
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
