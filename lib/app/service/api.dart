import 'package:flutter/material.dart';
import 'package:flutter_api/app/service/api_key.dart';

enum EndPoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class API {
  final String apiKey;
  static final String host = "ncov2019-admin.firebaseapp.com";

  static Map<EndPoint, String> _paths = {
    EndPoint.cases: "cases",
    EndPoint.casesSuspected: "casesSuspected",
    EndPoint.casesConfirmed: "casesConfirmed",
    EndPoint.deaths: "deaths",
    EndPoint.recovered: "recovered",
  };

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
        path: _paths[endpoint],
      );
}
