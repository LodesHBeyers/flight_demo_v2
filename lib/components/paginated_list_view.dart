import 'package:flight_demo_v2/components/flight_card.dart';
import 'package:flight_demo_v2/viewmodels/flight_list_view_model.dart';
import 'package:flight_demo_v2/viewmodels/flights_view_model.dart';
import 'package:flight_demo_v2/viewmodels/user_selection_view_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class PaginatedFlightsListView extends StatefulWidget {
  final Client client;

  const PaginatedFlightsListView({Key? key, required this.client})
      : super(key: key);

  @override
  _PaginatedFlightsListViewState createState() =>
      _PaginatedFlightsListViewState();
}

class _PaginatedFlightsListViewState extends State<PaginatedFlightsListView> {
  ScrollController _scrollController = ScrollController();
  int offset = 10;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    _scrollController.addListener(() async{
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        isLoading = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final flightListViewModel = Provider.of<FlightListViewModel>(context, listen: false);
    final iataCode = Provider.of<UserSelectionViewModel>(context, listen: false).selectedAirport.iataCode;

    appendList (stateToSet) async{
      await flightListViewModel.loadMoreFlights(client: widget.client, iataCode: iataCode, offset: offset);
      offset+= 10;
      if(flightListViewModel.flightList.length <= offset){
        hasMore = false;
      }
      isLoading = false;
      stateToSet(() {});
    }

    return StatefulBuilder(
      builder: (context, listState){
        return ListView.builder(
          controller: _scrollController,
          itemCount: flightListViewModel.flightList.length,
          itemBuilder: (context, index) {
            if (index == flightListViewModel.flightList.length -1) {
              if(isLoading && hasMore) appendList(listState);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlightCard(flightViewModel: flightListViewModel.flightList[index]),
                  SizedBox(height: 5,),
                  hasMore ? CircularProgressIndicator() : SizedBox.shrink(),
                ],
              );
            }
            return FlightCard(flightViewModel: flightListViewModel.flightList[index]);
          },
        );
      }
    );
  }
}
