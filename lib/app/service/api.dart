import 'package:flutter/material.dart';
import 'package:flutter_api/app/service/api_key.dart';

enum EndPoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

extension EndPointExtension on EndPoint {
  String get title {
    switch (this) {
      case EndPoint.cases:
        return "Cases";
      case EndPoint.casesSuspected:
        return "CasesSuspected";
      case EndPoint.casesConfirmed:
        return "CasesConfirmed";
      case EndPoint.deaths:
        return "Death";
      case EndPoint.recovered:
        return "Recoverd";
      default:
        return "";
    }
  }

  String get assets {
    switch (this) {
      case EndPoint.cases:
        return "assets/count.png";
      case EndPoint.casesSuspected:
        return "assets/suspect.png";
      case EndPoint.casesConfirmed:
        return "assets/fever.png";
      case EndPoint.deaths:
        return "assets/suspect.png";
      case EndPoint.recovered:
        return "assets/patient.png";
      default:
        return "";
    }
  }

  String get path {
    switch (this) {
      case EndPoint.cases:
        return "cases";
      case EndPoint.casesSuspected:
        return "casesSuspected";
      case EndPoint.casesConfirmed:
        return "casesConfirmed";
      case EndPoint.deaths:
        return "deaths";
      case EndPoint.recovered:
        return "recovered";
      default:
        return "";
    }
  }
}

class API {
  final String apiKey;
  static final String host = "ncov2019-admin.firebaseapp.com";

  API({
    @required this.apiKey,
  });

  factory API.sandbox() => API(apiKey: APIKeys.sandboxKey);

  Uri tokenUri() => Uri(
        scheme: "https",
        host: host,
        path: "token",
      );

  Uri endpointUri(EndPoint endpoint) => Uri(
        scheme: "https",
        host: host,
        path: endpoint.path,
      );
}
