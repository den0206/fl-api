import 'package:flutter/material.dart';
import 'package:flutter_api/app/repositry/end_pointdata.dart';
import 'package:flutter_api/app/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService {
  DataCacheService({
    @required this.pref,
  });

  final SharedPreferences pref;

  static String valueKey(EndPoint endpoint) => "$endpoint/value";
  static String dateKey(EndPoint endpoint) => "$endpoint/date";

  Future<void> setData(EndPointsData data) async {
    data.values.forEach((endpoint, endPointData) async {
      await pref.setInt(
        valueKey(endpoint),
        endPointData.value,
      );

      await pref.setString(
        dateKey(endpoint),
        endPointData.date.toIso8601String(),
      );
    });
  }

  EndPointsData getData() {
    Map<EndPoint, EndPointData> values = {};

    EndPoint.values.forEach((endpoint) {
      final value = pref.getInt(valueKey(endpoint));
      final dateString = pref.getString(dateKey(endpoint));
      if (value != null && dateString != null) {
        final date = DateTime.tryParse(dateString);
        values[endpoint] = EndPointData(value: value, date: date);
      }
    });

    return EndPointsData(values: values);
  }
}
