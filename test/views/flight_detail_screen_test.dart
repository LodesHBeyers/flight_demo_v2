import 'package:flight_demo_v2/viewmodels/airport_view_model.dart';
import 'package:flight_demo_v2/viewmodels/flights_view_model.dart';
import 'package:flight_demo_v2/viewmodels/user_selection_view_model.dart';
import 'package:flight_demo_v2/views/flight_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:flutter_geocoder/services/local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../test_helpers/mock_airport.dart';
import '../test_helpers/mock_flight.dart';
import '../test_helpers/test_wrapper.dart';
import 'flight_detail_screen_test.mocks.dart';

void main() {
  testWidgets(
    'Given FlightDetailScreen When loading Should display CircularProgressIndicator',
    (WidgetTester tester) async {
      Widget widget = TestWrapper(
        child: Builder(
          builder: (context) {
            final userSelectionViewModel =
                Provider.of<UserSelectionViewModel>(context, listen: false);
            userSelectionViewModel
                .setSelectedAirport(AirportViewModel(airport: mockAirport));
            return FlightDetailScreen(
              flight: FlightViewModel(flight: mockFlight),
            );
          },
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Given FlightDetailScreen When exception thrown Should display error view',
    (WidgetTester tester) async {
      Widget widget = TestWrapper(
        child: Builder(
          builder: (context) {
            final userSelectionViewModel =
                Provider.of<UserSelectionViewModel>(context, listen: false);
            userSelectionViewModel
                .setSelectedAirport(AirportViewModel(airport: mockAirport));
            return FlightDetailScreen(
              flight: FlightViewModel(flight: erroneousMockFlight),
            );
          },
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 5));

      expect(find.text('Error Loading'), findsOneWidget);
    },
  );
}
