import 'package:flight_demo_v2/components/logo_image.dart';
import 'package:flight_demo_v2/viewmodels/airport_list_view_model.dart';
import 'package:flight_demo_v2/viewmodels/airport_view_model.dart';
import 'package:flight_demo_v2/viewmodels/user_selection_view_model.dart';
import 'package:flight_demo_v2/views/flight_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

enum ProviderState { Loading, Error, Loaded }

class AirportSelectScreen extends StatefulWidget {
  final Client client;

  const AirportSelectScreen({Key? key, required this.client}) : super(key: key);

  @override
  _AirportSelectScreenState createState() => _AirportSelectScreenState();
}

class _AirportSelectScreenState extends State<AirportSelectScreen> {
  ProviderState state = ProviderState.Loading;

  @override
  void initState() {
    final airportListViewModel =
        Provider.of<AirportListViewModel>(context, listen: false);
    _fetchAirports(airportListViewModel);
    super.initState();
  }

  Future _fetchAirports(AirportListViewModel airportListViewModel) async {
    try {
      await airportListViewModel.availableAirports(client: widget.client);
      state = ProviderState.Loaded;
      setState(() {});
    } catch (e) {
      state = ProviderState.Error;
      setState(() {});
    }
  }

  Widget _renderLoad() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _renderError() {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('Error Loading'),
            TextButton(
                onPressed: () {
                  final airportListViewModel =
                  Provider.of<AirportListViewModel>(context, listen: false);
                  _fetchAirports(airportListViewModel);
                },
                child: Text('Retry'))
          ],
        ),
      ),
    );
  }

  Widget _renderAirportSelect(context, List<AirportViewModel> airportList) {
    double screenWidth = MediaQuery.of(context).size.width;
    airportList.sort((a, b) => a.airportName.compareTo(b.airportName));

    return Consumer<UserSelectionViewModel>(builder: (context, state, child) {
      return DropdownButton<AirportViewModel>(
        hint: Text('Select Airport'),
        items: airportList.map((airport) {
          return DropdownMenuItem<AirportViewModel>(
            value: airport,
            child: Container(
              width: screenWidth * .5,
              child: Text(
                airport.airportName,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: TextStyle(color: Color(0xff202526)),
              ),
            ),
          );
        }).toList(),
        onChanged: (val) {
          if (val == null) throw Exception('Value is null');
          state.setSelectedAirport(val);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FlightSelectScreen(
                iataCode: state.selectedAirport.iataCode, client: widget.client,
              ),
            ),
          );
        },
      );
    });
  }

  Widget _renderDisplay(List<AirportViewModel> list) {
    switch (state) {
      case ProviderState.Loading:
        return _renderLoad();
      case ProviderState.Error:
        return _renderError();
      case ProviderState.Loaded:
        return _renderAirportSelect(context, list);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * .15,
        ),
        Container(
          width: size.width,
          height: size.height * .45,
          child: Center(
            child: LogoImage(),
          ),
        ),
        Expanded(
          child: Container(child: Consumer<AirportListViewModel>(
            builder: (context, provider, child) {
              return _renderDisplay(provider.airportList);
            },
          )),
        )
      ],
    );
  }
}

//NOTES
//Cannot implement search as API does not allow for search in query on free plan
//Cannot load all airports as it's 65 API calls and working with 500 max calls
