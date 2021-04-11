import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_api/app/repositry/end_pointdata.dart';
import 'package:flutter_api/app/service/api.dart';
import 'package:http/http.dart' as http;

class APIService {
  final API api;

  APIService({
    @required this.api,
  });

  Future<String> getAccesToken() async {
    final response = await http.post(
      api.tokenUri(),
      headers: {"Authorization": "Basic ${api.apiKey}"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final accessToken = data["access_token"];
      if (accessToken != null) {
        return accessToken;
      }
    }

    throw response;
  }

  Future<EndPointData> getEndPointData({
    @required String accessToken,
    @required EndPoint endPoint,
  }) async {
    final uri = api.endpointUri(endPoint);
    print(uri);
    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endPoint];
        final value = endpointData[responseJsonKey];

        final String dateString = endpointData["date"];
        final date = DateTime.tryParse(dateString);

        if (value != null) {
          return EndPointData(value: value, date: date);
        }
      }
    }

    print(response.reasonPhrase);
    throw response;
  }

  static Map<EndPoint, String> _responseJsonKeys = {
    EndPoint.cases: "cases",
    EndPoint.casesSuspected: "data",
    EndPoint.casesConfirmed: "data",
    EndPoint.deaths: "data",
    EndPoint.recovered: "data",
  };
}
