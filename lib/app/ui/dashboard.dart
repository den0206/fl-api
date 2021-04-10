import 'package:flutter/material.dart';
import 'package:flutter_api/app/repositry/data_repositry.dart';
import 'package:flutter_api/app/repositry/end_pointdata.dart';
import 'package:flutter_api/app/service/api.dart';
import 'package:flutter_api/app/ui/endPoint_card.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  EndPointData _endPointData;

  @override
  void initState() {
    super.initState();
    _updateDate();
  }

  Future<void> _updateDate() async {
    final dataRepositry = Provider.of<DataRepositry>(context, listen: false);
    final endPointData = await dataRepositry.getAllEndPointData();

    setState(() {
      _endPointData = endPointData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tracker'),
        ),
        body: RefreshIndicator(
          onRefresh: () => _updateDate(),
          child: ListView(
            children: [
              for (var endPoint in EndPoint.values)
                EndPointcard(
                  endPoint: endPoint,
                  value: _endPointData != null
                      ? _endPointData.values[endPoint]
                      : null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
