
import 'package:flight_demo_v2/viewmodels/airport_view_model.dart';
import 'package:flutter/cupertino.dart';

class UserSelectionViewModel extends ChangeNotifier{
  late AirportViewModel selectedAirport;

  void setSelectedAirport(AirportViewModel airport){
    selectedAirport = airport;
  }
}