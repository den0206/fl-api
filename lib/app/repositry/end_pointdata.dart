import 'package:flutter/material.dart';
import 'package:flutter_api/app/service/api.dart';

class EndPointsData {
  EndPointsData({@required this.values});

  final Map<EndPoint, EndPointData> values;

  EndPointData get cases => values[0];
  EndPointData get casesSuspected => values[1];
  EndPointData get casesConfirmed => values[2];
  EndPointData get deaths => values[3];
  EndPointData get recovered => values[4];
}

class EndPointData {
  EndPointData({
    @required this.value,
    this.date,
  }) : assert(value != null);

  final int value;
  final DateTime date;
}
