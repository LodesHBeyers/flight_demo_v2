import 'dart:convert';
import 'package:flight_demo_v2/components/paginated_list_view.dart';
import 'package:flight_demo_v2/viewmodels/airport_view_model.dart';
import 'package:flight_demo_v2/viewmodels/user_selection_view_model.dart';
import 'package:flight_demo_v2/views/flight_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../test_helpers/mock_airport.dart';
import '../test_helpers/mock_flights_data.dart';
import '../test_helpers/test_wrapper.dart';
import '../viewmodels/airport_list_view_model_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  testWidgets(
    'Given FlightSelectScreen When loading Should display CircularProgressIndicator',
        (WidgetTester tester) async {
      MockClient mockClient = MockClient();

      when(mockClient.get(any)).thenAnswer((realInvocation) async => Response('', 200));
      Widget widget = TestWrapper(
        child: Builder(
          builder: (context){
            final userSelectionViewModel = Provider.of<UserSelectionViewModel>(context, listen: false);
            userSelectionViewModel.setSelectedAirport(AirportViewModel(airport: mockAirport));
            return FlightSelectScreen(client: mockClient, iataCode: '',);
          },
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Given FlightSelectScreen When exception thrown Should display error text',
        (WidgetTester tester) async {
      MockClient mockClient = MockClient();

      when(mockClient.get(any)).thenAnswer((realInvocation) async => Response('', 400));
      Widget widget = TestWrapper(
        child: Builder(
          builder: (context){
            final userSelectionViewModel = Provider.of<UserSelectionViewModel>(context, listen: false);
            userSelectionViewModel.setSelectedAirport(AirportViewModel(airport: mockAirport));
            return FlightSelectScreen(client: mockClient, iataCode: '',);
          },
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.text('Error Loading'), findsOneWidget);
    },
  );

  testWidgets(
    'Given FlightSelectScreen When loaded Should display PaginatedFlightsListView',
        (WidgetTester tester) async {
      MockClient mockClient = MockClient();

      when(mockClient.get(any)).thenAnswer((realInvocation) async => Response(jsonEncode(mockFlightsData), 200));
      Widget widget = TestWrapper(
        child: Builder(
          builder: (context){
            final userSelectionViewModel = Provider.of<UserSelectionViewModel>(context, listen: false);
            userSelectionViewModel.setSelectedAirport(AirportViewModel(airport: mockAirport));
            return FlightSelectScreen(client: mockClient, iataCode: '',);
          },
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pump();

      expect(find.byType(PaginatedFlightsListView), findsOneWidget);
    },
  );
}