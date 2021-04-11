import 'package:flutter/material.dart';
import 'package:flutter_api/app/service/api_service.dart';
import 'package:flutter_api/app/repositry/data_repositry.dart';
import 'package:flutter_api/app/service/api.dart';
import 'package:flutter_api/app/service/api_key.dart';
import 'package:flutter_api/app/ui/dashboard.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() async {
  // Intl.defaultLocale = "ja_JP";
  // await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DataRepositry>(
          create: (context) => DataRepositry(
            apiService: APIService(
              api: API(apiKey: APIKeys.sandboxKey),
            ),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF1010101),
          cardColor: Color(0xFF222222),
        ),
        home: DashBoard(),
      ),
    );
  }
}

// class Home extends StatefulWidget {
//   Home({Key key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int _cases;
//   int _death;

//   void getAccessToken() async {
//     final apiService = APIService(api: API(apiKey: APIKeys.sandboxKey));
//     final accessToken = await apiService.getAccesToken();
//     final cases = await apiService.getEndPointData(
//       accessToken: accessToken,
//       endPoint: EndPoint.cases,
//     );

//     final deaths = await apiService.getEndPointData(
//       accessToken: accessToken,
//       endPoint: EndPoint.deaths,
//     );

//     setState(() {
//       _cases = cases;
//       _death = deaths;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Title'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (_cases != null)
//               Text(
//                 _cases.toString(),
//               ),
//             if (_death != null)
//               Text(
//                 _death.toString(),
//               )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         backgroundColor: Colors.blue,
//         tooltip: "Get",
//         onPressed: getAccessToken,
//       ),
//     );
//   }
// }
