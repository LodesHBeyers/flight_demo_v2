import 'dart:convert';

import 'package:flight_demo_v2/components/flight_card.dart';
import 'package:flight_demo_v2/components/paginated_list_view.dart';
import 'package:flight_demo_v2/viewmodels/airport_view_model.dart';
import 'package:flight_demo_v2/viewmodels/flight_list_view_model.dart';
import 'package:flight_demo_v2/viewmodels/flights_view_model.dart';
import 'package:flight_demo_v2/viewmodels/user_selection_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../test_helpers/mock_airport.dart';
import '../test_helpers/mock_flight.dart';
import '../test_helpers/mock_flights_data.dart';
import '../test_helpers/test_wrapper.dart';
import '../viewmodels/airport_list_view_model_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  MockClient mockClient = MockClient();

  testWidgets(
    'Given PaginatedFlightsListView When loaded Should display FlightCards',
    (WidgetTester tester) async {
      Widget widget = TestWrapper(
        child: Builder(
          builder: (context) {
            final userSelectionViewModel =
                Provider.of<UserSelectionViewModel>(context, listen: false);
            userSelectionViewModel
                .setSelectedAirport(AirportViewModel(airport: mockAirport));

            final flightListViewModel =
                Provider.of<FlightListViewModel>(context, listen: false);
            flightListViewModel.flightList = [
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
            ];

            return PaginatedFlightsListView(client: mockClient);
          },
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.byType(FlightCard), findsWidgets);
    },
  );

  testWidgets(
    'Given PaginatedFlightsListView When scrolled to bottom Should display '
        'CircularProgressIndicator and load more flights',
        (WidgetTester tester) async {
      Widget widget = TestWrapper(
        child: Builder(
          builder: (context) {
            final userSelectionViewModel =
            Provider.of<UserSelectionViewModel>(context, listen: false);
            userSelectionViewModel
                .setSelectedAirport(AirportViewModel(airport: mockAirport));
            
            when(mockClient.get(any)).thenAnswer((realInvocation) async => Response(jsonEncode(mockFlightsData), 200));

            final flightListViewModel =
            Provider.of<FlightListViewModel>(context, listen: false);
            flightListViewModel.flightList = [
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
              FlightViewModel(flight: mockFlight),
            ];

            return PaginatedFlightsListView(client: mockClient);
          },
        ),
      );

      await tester.pumpWidget(widget);
      
      await tester.drag(find.byType(PaginatedFlightsListView), Offset(0, - 2200));

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump();

      expect(find.byType(FlightCard), findsWidgets);
    },
  );
}
