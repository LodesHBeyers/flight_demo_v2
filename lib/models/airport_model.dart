class Airport{
  final String airportName;
  final String iataCode;
  final String longitude;
  final String latitude;

  Airport({
    this.airportName = '',
    this.iataCode = '',
    this.latitude = '',
    this.longitude = '',
  });

  factory Airport.fromJson(Map<String, dynamic> json){
    return Airport(
      airportName: json['airport_name'],
      iataCode: json['iata_code'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }
}