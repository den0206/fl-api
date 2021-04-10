import 'package:flutter/material.dart';
import 'package:flutter_api/app/repositry/data_repositry.dart';
import 'package:flutter_api/app/service/api.dart';
import 'package:flutter_api/ui/endPoint_card.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _cases;

  @override
  void initState() {
    super.initState();
    _updateDate();
  }

  Future<void> _updateDate() async {
    final dataRepositry = Provider.of<DataRepositry>(context, listen: false);
    final cases = await dataRepositry.getEndPointData(EndPoint.cases);

    setState(() {
      _cases = cases;
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
              EndPointcard(
                endPoint: EndPoint.cases,
                value: _cases,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
