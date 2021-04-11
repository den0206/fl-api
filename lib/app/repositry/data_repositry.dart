import 'package:flutter/material.dart';
import 'package:flutter_api/app/repositry/end_pointdata.dart';
import 'package:flutter_api/app/service/api_service.dart';
import 'package:flutter_api/app/service/api.dart';
import 'package:flutter_api/app/service/dart_cache_service.dart';
import 'package:http/http.dart';

class DataRepositry {
  DataRepositry({
    @required this.apiService,
    @required this.cacheService,
  });

  final APIService apiService;
  final DataCacheService cacheService;

  String _accessToken;

  EndPointsData getAllEndpointsCacheData() => cacheService.getData();

  Future<EndPointData> getEndPointData(EndPoint endpoint) async =>
      await _getDataRefreshToken<EndPointData>(
        onGetData: () => apiService.getEndPointData(
            accessToken: _accessToken, endPoint: endpoint),
      );

  Future<EndPointsData> getAllEndPointData() async {
    final endPointsData = await _getDataRefreshToken<EndPointsData>(
      onGetData: () => _getAllEndpointData(),
    );

    await cacheService.setData(endPointsData);

    return endPointsData;
  }

  Future<T> _getDataRefreshToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccesToken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        /// refresh
        _accessToken = await apiService.getAccesToken();
        return await onGetData();
      }

      rethrow;
    }
  }

  Future<EndPointsData> _getAllEndpointData() async {
    final values = await Future.wait([
      apiService.getEndPointData(
          accessToken: _accessToken, endPoint: EndPoint.cases),
      apiService.getEndPointData(
          accessToken: _accessToken, endPoint: EndPoint.casesSuspected),
      apiService.getEndPointData(
          accessToken: _accessToken, endPoint: EndPoint.casesConfirmed),
      apiService.getEndPointData(
          accessToken: _accessToken, endPoint: EndPoint.deaths),
      apiService.getEndPointData(
          accessToken: _accessToken, endPoint: EndPoint.recovered),
    ]);

    return EndPointsData(
      values: {
        EndPoint.cases: values[0],
        EndPoint.casesSuspected: values[1],
        EndPoint.casesConfirmed: values[2],
        EndPoint.deaths: values[3],
        EndPoint.recovered: values[4],
      },
    );
  }
}
