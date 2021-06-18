import 'package:flight_demo_v2/models/airport_model.dart';

class AirportViewModel{
  Airport _airport;

  AirportViewModel({required Airport airport}): _airport = airport;

  String get airportName{
    return _airport.airportName;
  }

  String get iataCode{
    return _airport.iataCode;
  }

  String get longitude{
    return _airport.longitude;
  }

  String get latitude{
    return _airport.latitude;
  }
}