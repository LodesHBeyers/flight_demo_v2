import 'package:flight_demo_v2/models/airport_model.dart';
import 'package:flight_demo_v2/services/web_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'airport_view_model.dart';

class AirportListViewModel with ChangeNotifier{
  List<AirportViewModel> airportList = [];

  Future availableAirports({required Client client}) async{
    List<Airport> airports = await WebServices.fetchAirports(client: client);

    airportList = airports.map((airport) => AirportViewModel(airport: airport)).toList();

    notifyListeners();
  }
}