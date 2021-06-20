import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flight_demo_v2/viewmodels/airport_list_view_model.dart';
import 'package:flight_demo_v2/viewmodels/flight_list_view_model.dart';
import 'package:flight_demo_v2/viewmodels/user_selection_view_model.dart';
import 'package:flight_demo_v2/views/airport_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'components/connection_checker_overlay.dart';

void main() {
  runApp(MyApp());
}

Client client = Client();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FlightListViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => AirportListViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserSelectionViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flight Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ConnectionWrapper()
      ),
    );
  }
}

class ConnectionWrapper extends StatefulWidget {
  const ConnectionWrapper({Key? key}) : super(key: key);

  @override
  _ConnectionWrapperState createState() => _ConnectionWrapperState();
}

class _ConnectionWrapperState extends State<ConnectionWrapper> {
  late StreamSubscription<ConnectivityResult> subscription;
  bool hasConnection = true;

  @override
  initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((
        ConnectivityResult result) {
      if(result == ConnectivityResult.none){
        hasConnection = false;
      }else{
        hasConnection = true;
      }
      setState(() {

      });
    });
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Material(child: AirportSelectScreen(client: client,)),
          ConnectionCheckerWrapper(hasConnection: hasConnection,)
        ],
      ),
    );
  }
}

