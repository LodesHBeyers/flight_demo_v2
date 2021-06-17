class Flight {
  final DateTime? flightDate;
  final String flightStatus;
  final String departureAirport;
  final String departureTimeZone;
  final DateTime? departureDateTime;
  final String departureTerminal;
  final String departureGate;
  final String arrivalAirport;
  final String arrivalTimeZone;
  final DateTime? arrivalDateTime;
  final String airlineName;
  final String flightNumber;

  Flight({
    this.flightDate,
    this.flightStatus = '',
    this.departureAirport = '',
    this.departureTimeZone = '',
    this.departureDateTime,
    this.departureTerminal = '',
    this.departureGate = '',
    this.arrivalAirport = '',
    this.arrivalTimeZone = '',
    this.arrivalDateTime,
    this.airlineName = '',
    this.flightNumber = '',
  });

  factory Flight.fromJson(Map<String, dynamic> json){
    return Flight(
      flightDate: DateTime.parse(json['flight_date']),
      flightStatus: json['flight_status'] ?? '',
      departureAirport: json['departure']['airport'] ?? '',
      departureTimeZone: json['departure']['timezone'] ?? '',
      departureDateTime: DateTime.parse(json['departure']['scheduled']),
      departureTerminal: json['departure']['terminal'] ?? '',
      departureGate: json['departure']['gate'] ?? '',
      arrivalAirport: json['arrival']['airport'] ?? '',
      arrivalTimeZone: json['arrival']['timezone'] ?? '',
      arrivalDateTime: DateTime.parse(json['arrival']['scheduled']),
      airlineName: json['airline']['name'] ?? '',
      flightNumber: json['flight']['number'] ?? '',
    );
  }
}