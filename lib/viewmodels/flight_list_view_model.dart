import 'package:flight_demo_v2/models/flight_model.dart';
import 'package:flight_demo_v2/services/web_services.dart';
import 'package:flight_demo_v2/viewmodels/flights_view_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class FlightListViewModel with ChangeNotifier{
  List<FlightViewModel> flightList = [];

  Future availableFlights({required Client client, required String iataCode}) async{
    List<Flight> flights = await WebServices.fetchFlights(client: client, iataCode: iataCode);

    flightList = flights.map((flight) => FlightViewModel(flight: flight)).toList();

    notifyListeners();
  }

  Future loadMoreFlights({required Client client, required String iataCode}) async{
    List<Flight> flights = await WebServices.fetchMoreFlights(client: client, iataCode: iataCode);

    flightList += flights.map((flight) => FlightViewModel(flight: flight)).toList();

    notifyListeners();
  }

  emptyFlights(){
    flightList = [];
  }
}