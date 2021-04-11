import 'package:flutter/material.dart';
import 'package:flutter_api/app/repositry/end_pointdata.dart';
import 'package:flutter_api/app/service/api.dart';
import 'package:intl/intl.dart';

class EndPointcard extends StatelessWidget {
  const EndPointcard({Key key, @required this.endPoint, @required this.value})
      : super(key: key);

  final EndPoint endPoint;
  final EndPointData value;

  String get formattedValue {
    if (value == null) {
      return "";
    }

    return NumberFormat("#,###,###,###").format(value.value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                endPoint.title,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(image: AssetImage(endPoint.assets)),
                    // Image.asset(EndPointExtension.assetName(endPoint)),
                    Text(
                      formattedValue,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
