import 'package:flight_demo_v2/components/paginated_list_view.dart';
import 'package:flight_demo_v2/viewmodels/flight_list_view_model.dart';
import 'package:flight_demo_v2/viewmodels/flights_view_model.dart';
import 'package:flight_demo_v2/viewmodels/user_selection_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';

class FlightSelectScreen extends StatefulWidget {
  final String iataCode;
  final Client client;

  const FlightSelectScreen({Key? key, required this.iataCode, required this.client}) : super(key: key);

  @override
  _FlightSelectScreenState createState() => _FlightSelectScreenState();
}

enum ProviderState { Loading, Error, Loaded }

class _FlightSelectScreenState extends State<FlightSelectScreen> {
  ProviderState state = ProviderState.Loading;

  @override
  void initState() {
    final flightListViewModel = Provider.of<FlightListViewModel>(context, listen: false);
    _fetchFlights(flightListViewModel);
    super.initState();
  }

  Future _fetchFlights(FlightListViewModel flightListViewModel) async{
    final selectedAirport = Provider.of<UserSelectionViewModel>(context, listen: false).selectedAirport;
    try {
      await flightListViewModel.availableFlights(iataCode: selectedAirport.iataCode , client: widget.client);
      state = ProviderState.Loaded;
      setState(() {});
    } catch (e) {
      state = ProviderState.Error;
      setState(() {});
    }
  }

  Widget _loadingView(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _errorView(){
    return Container(
      child: Center(
        child: Text('Error Loading'),
      ),
    );
  }

  Widget _renderDisplay(List<FlightViewModel> list) {
    switch (state) {
      case ProviderState.Loading:
        return _loadingView();
      case ProviderState.Error:
        return _errorView();
      case ProviderState.Loaded:
        return PaginatedFlightsListView(client: widget.client);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flights'),
      ),
      body: Consumer<FlightListViewModel>(
        builder: (context, provider, child){
          return _renderDisplay(provider.flightList);
        },
      ),
    );
  }
}
