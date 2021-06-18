import 'package:flight_demo_v2/models/flight_model.dart';

class FlightViewModel{
  Flight _flight;

  FlightViewModel({required Flight flight}): _flight = flight;

  DateTime? get flightDate{
    return _flight.flightDate;
  }

  String get flightStatus{
    return _flight.flightStatus;
  }

  String get departureAirport{
    return _flight.departureAirport;
  }

  String get departureTimeZone{
    return _flight.departureTimeZone;
  }

  DateTime? get departureDateTime{
    return _flight.departureDateTime;
  }

  String get departureTerminal{
    return _flight.departureTerminal;
  }

  String get departureGate{
    return _flight.departureGate;
  }

  String get arrivalAirport{
    return _flight.arrivalAirport;
  }

  String get arrivalTimeZone{
    return _flight.arrivalTimeZone;
  }

  DateTime? get arrivalDateTime{
    return _flight.arrivalDateTime;
  }

  String get airlineName{
    return _flight.airlineName;
  }

  String get flightNumber{
    return _flight.flightNumber;
  }
}