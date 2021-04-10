import 'package:flutter/material.dart';
import 'package:flutter_api/app/service/api.dart';

class EndPointData {
  EndPointData({@required this.values});

  final Map<EndPoint, int> values;

  int get cases => values[0];
  int get casesSuspected => values[1];
  int get casesConfirmed => values[2];
  int get deaths => values[3];
  int get recovered => values[4];
}
