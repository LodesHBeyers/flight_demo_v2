
import 'package:flight_demo_v2/models/flight_model.dart';

final Flight mockFlight = Flight(
  flightDate: DateTime.now(),
  flightStatus: '',
  departureAirport: '',
  departureTimeZone: '',
  departureDateTime:DateTime.now(),
  departureTerminal: '',
  departureGate: '',
  arrivalAirport: 'ArrivalAirport',
  arrivalTimeZone: '',
  arrivalDateTime:DateTime.now(),
  airlineName: '',
  flightNumber: '',
);

final Flight erroneousMockFlight = Flight(
  flightDate: null,
  flightStatus: '',
  departureAirport: '',
  departureTimeZone: '',
  departureDateTime: null,
  departureTerminal: '',
  departureGate: '',
  arrivalAirport: '',
  arrivalTimeZone: '',
  arrivalDateTime: null,
  airlineName: '',
  flightNumber: '',
);