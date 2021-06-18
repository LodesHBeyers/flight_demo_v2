
import 'package:flight_demo_v2/viewmodels/airport_list_view_model.dart';
import 'package:flight_demo_v2/viewmodels/flight_list_view_model.dart';
import 'package:flight_demo_v2/viewmodels/user_selection_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestWrapper extends StatelessWidget {
  final Widget child;
  const TestWrapper({Key? key, required this.child}) : super(key: key);

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
        home: child,
      ),
    );
  }
}
