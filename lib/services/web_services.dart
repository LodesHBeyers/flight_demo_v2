import 'dart:convert';
import 'package:flight_demo_v2/models/airport_model.dart';
import 'package:flight_demo_v2/models/flight_model.dart';
import 'package:http/http.dart' as http;

String airportsAPIUrl =
    'http://api.aviationstack.com/v1/airports?access_key=6867ad02c34e331babc046a0124b156a';

String flightsAPIUrl =
    'http://api.aviationstack.com/v1/flights?access_key=6867ad02c34e331babc046a0124b156a&limit=10';

class WebServices{

  static Future<List<Flight>> fetchFlights({required http.Client client, String iataCode = ''}) async{
    List<Flight> flightsList = [];
    String url = flightsAPIUrl + (iataCode.isNotEmpty ? '&dep_iata=$iataCode' : '');

    final http.Response response = await client.get(Uri.parse(url));

    try{
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);

        for(var data in jsonData['data']){
          flightsList.add(Flight.fromJson(data));
        }
        return flightsList;
      }else{
       throw Exception('Unable to fetch flights');
      }
    }catch(e){
      throw Exception('Unable to connect to the api');
    }
  }

  static Future<List<Flight>> fetchMoreFlights({required http.Client client, String iataCode = ''}) async{
    List<Flight> flightsList = [];
    String url = flightsAPIUrl + (iataCode.isNotEmpty ? '&dep_iata=$iataCode' : '');

    final http.Response response = await client.get(Uri.parse(url));

    try{
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);

        for(var data in jsonData['data']){
          flightsList.add(Flight.fromJson(data));
        }
        return flightsList;
      }else{
        throw Exception('Unable to fetch flights');
      }
    }catch(e){
      throw Exception('Unable to connect to the api');
    }
  }

  static Future<List<Airport>> fetchAirports({required http.Client client}) async{
    List<Airport> airportList = [];

    final http.Response response = await client.get(Uri.parse(airportsAPIUrl));

    try{
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);

        for(var data in jsonData['data']){
          airportList.add(Airport.fromJson(data));
        }
        return airportList;
      }else{
        throw Exception('Unable to fetch flights');
      }
    }catch(e){
      throw Exception('Unable to connect to the api');
    }
  }
}