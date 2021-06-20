import 'package:flight_demo_v2/components/map_container.dart';
import 'package:flight_demo_v2/helpers/date_time_formatter.dart';
import 'package:flight_demo_v2/viewmodels/airport_view_model.dart';
import 'package:flight_demo_v2/viewmodels/flights_view_model.dart';
import 'package:flight_demo_v2/viewmodels/user_selection_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class FlightDetailScreen extends StatefulWidget {
  final FlightViewModel flight;

  const FlightDetailScreen({Key? key, required this.flight}) : super(key: key);

  @override
  _FlightDetailScreenState createState() => _FlightDetailScreenState();
}

enum ProviderState { Loading, Error, Loaded }

class _FlightDetailScreenState extends State<FlightDetailScreen> {
  late AirportViewModel airport;
  late LatLng departureLatLng;
  late LatLng arrivalLatLng;
  late double travelDistance;
  late String travelTime;
  late Map departureDateTime;
  late Map arrivalDateTime;


  ProviderState state = ProviderState.Loading;

  Map unknownDateTime = {'time': 'Unknown Time', 'date': 'Unknown Date'};

  @override
  void initState() {
    airport = Provider.of<UserSelectionViewModel>(context, listen: false)
        .selectedAirport;
    _getRouteDetails();
    super.initState();
  }

  Future _getRouteDetails() async {
    departureDateTime = widget.flight.departureDateTime != null
        ? formatDateTime(widget.flight.departureDateTime as DateTime)
        : unknownDateTime;

   arrivalDateTime = widget.flight.arrivalDateTime != null
        ? formatDateTime(widget.flight.arrivalDateTime as DateTime)
        : unknownDateTime;

    try {
      if(widget.flight.arrivalAirport.length == 0){
        throw Exception('Invalid Airport Name');
      }
      final addresses = await Geocoder.local
          .findAddressesFromQuery(widget.flight.arrivalAirport);


      final lat = addresses.first.coordinates.latitude ?? 0;
      final long = addresses.first.coordinates.longitude ?? 0;
      if(lat == 0|| long == 0){
        throw Exception('LatLng error');
      }else{
        arrivalLatLng = LatLng(lat, long);
      }

      departureLatLng = LatLng(
          double.parse(airport.latitude), double.parse(airport.longitude));

      travelDistance = Geolocator.distanceBetween(
        departureLatLng.latitude,
        departureLatLng.longitude,
        arrivalLatLng.latitude,
        arrivalLatLng.longitude,
      );
      final depTime = widget.flight.departureDateTime ?? DateTime.now();
      final arrTime = widget.flight.arrivalDateTime ?? DateTime.now();

      travelTime = getTimeInHoursMins(depTime.difference(arrTime).inMinutes);

      state = ProviderState.Loaded;
      setState(() {});
    } catch (e) {
      state = ProviderState.Error;
      setState(() {});
    }
  }

  String getTimeInHoursMins(int mins) {
    final hrs = (mins / 60).floor();
    final mnts = (mins - (hrs * 60));
    final String minutes =
        mnts.toString().length == 1 ? '0$mnts' : mnts.toString();
    final hours = hrs.toString();
    return '$hours:$minutes';
  }

  Widget _loadingView() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _errorView() {
    return Container(
      child: Center(
        child: Text('Error Loading'),
      ),
    );
  }

  Widget _loadedView() {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * .38,
                  height: size.height * .12,
                  child: Center(
                    child: Text(
                      widget.flight.departureAirport,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.airplanemode_on_rounded,
                    color: Colors.black54,
                    size: 32,
                  ),
                ),
                Container(
                  width: size.width * .38,
                  height: size.height * .12,
                  child: Center(
                    child: Text(
                      widget.flight.arrivalAirport,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      departureDateTime['time'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: size.width * .26,
                      child: Text(
                        'South African/Europe',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    Text(
                      departureDateTime['date'],
                      style: TextStyle(fontSize: 13, color: Colors.blue),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Flight Time:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      travelTime,
                      style: TextStyle(fontSize: 13, color: Colors.blue),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      arrivalDateTime['time'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.right,
                    ),
                    Container(
                      width: size.width * .26,
                      child: Text(
                        widget.flight.arrivalTimeZone,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Text(
                      arrivalDateTime['date'],
                      style: TextStyle(fontSize: 13, color: Colors.blue),
                      textAlign: TextAlign.right,
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Container(
            width: size.width,
            height: size.height * .4,
            child: MapsContainer(
              arrivalLatLng: arrivalLatLng,
              departureLatLng: departureLatLng,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.flight.airlineName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Departure Terminal: '),
                          Text(widget.flight.departureTerminal)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Departure Gate: '),
                          Text(widget.flight.departureGate),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _renderDisplay() {
    switch (state) {
      case ProviderState.Loading:
        return _loadingView();
      case ProviderState.Error:
        return _errorView();
      case ProviderState.Loaded:
        return _loadedView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight:' + widget.flight.flightNumber),
      ),
      body: _renderDisplay(),
    );
  }
}
