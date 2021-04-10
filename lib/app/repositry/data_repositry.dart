import 'package:flutter/material.dart';
import 'package:flutter_api/app/api_service.dart';
import 'package:flutter_api/app/service/api.dart';
import 'package:http/http.dart';

class DataRepositry {
  DataRepositry({
    @required this.apiService,
  });

  final APIService apiService;
  String _accessToken;

  Future<int> getEndPointData(EndPoint endpoint) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccesToken();
      }
      return await apiService.getEndPointData(
          accessToken: _accessToken, endPoint: endpoint);
    } on Response catch (response) {
      if (response.statusCode == 401) {
        /// refresh
        _accessToken = await apiService.getAccesToken();
        return await apiService.getEndPointData(
            accessToken: _accessToken, endPoint: endpoint);
      }

      rethrow;
    }
  }
}
