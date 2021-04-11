import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_api/app/repositry/data_repositry.dart';
import 'package:flutter_api/app/repositry/end_pointdata.dart';
import 'package:flutter_api/app/service/api.dart';
import 'package:flutter_api/app/ui/endPoint_card.dart';
import 'package:flutter_api/app/ui/last_updated.status.dart';
import 'package:flutter_api/app/ui/show_alertDialog.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  EndPointsData _endPointsData;

  @override
  void initState() {
    super.initState();
    _updateDate();
  }

  Future<void> _updateDate() async {
    try {
      final dataRepositry = Provider.of<DataRepositry>(context, listen: false);
      final endPointsData = await dataRepositry.getAllEndPointData();

      setState(() {
        _endPointsData = endPointsData;
      });
    } on SocketException catch (_) {
      /// internet Error
      showAlertDialog(
          context: context,
          title: "Connect Error",
          content: "Please try again",
          defaultActionText: "OK");
    } catch (_) {
      showAlertDialog(
          context: context,
          title: "Unkown Error",
          content: "Please try again",
          defaultActionText: "OK");
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdateDateFormatter(
        lastUpdate: _endPointsData != null
            ? _endPointsData.values[EndPoint.cases].date
            : null);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tracker'),
        ),
        body: RefreshIndicator(
          onRefresh: () => _updateDate(),
          child: ListView(
            children: [
              LastUpdatedStatusText(
                text: formatter.formatDateToString(),
              ),
              for (var endPoint in EndPoint.values)
                EndPointcard(
                  endPoint: endPoint,
                  value: _endPointsData != null
                      ? _endPointsData.values[endPoint]
                      : null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
