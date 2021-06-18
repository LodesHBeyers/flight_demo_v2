import 'package:flight_demo_v2/viewmodels/airport_list_view_model.dart';
import 'package:flight_demo_v2/viewmodels/flight_list_view_model.dart';
import 'package:flight_demo_v2/viewmodels/user_selection_view_model.dart';
import 'package:flight_demo_v2/views/airport_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

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
        home: Material(child: AirportSelectScreen(client: client,)),
      ),
    );
  }
}
