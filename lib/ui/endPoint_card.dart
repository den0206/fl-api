import 'package:flutter/material.dart';
import 'package:flutter_api/app/service/api.dart';

class EndPointcard extends StatelessWidget {
  const EndPointcard({Key key, this.endPoint, this.value}) : super(key: key);

  final EndPoint endPoint;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cases",
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                value != null ? value.toString() : "",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
