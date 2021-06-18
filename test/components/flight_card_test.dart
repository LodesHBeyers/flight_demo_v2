import 'package:flight_demo_v2/components/flight_card.dart';
import 'package:flight_demo_v2/viewmodels/flights_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../test_helpers/mock_flight.dart';
import '../test_helpers/test_wrapper.dart';

void main() {
  testWidgets(
    'Given FlightCard When passed a complete FlightViewModel Should render '
        'all children',
        (WidgetTester tester) async {
      Widget widget = TestWrapper(
        child: FlightCard(flightViewModel: FlightViewModel(flight: mockFlight),),
      );

      await tester.pumpWidget(widget);

      expect(find.byType(FlightCard), findsOneWidget);
    },
  );

  testWidgets(
    'Given FlightCard When passed an incomplete FlightViewModel with dates '
        'missing Should render unknown date and time',
        (WidgetTester tester) async {
      Widget widget = TestWrapper(
        child: FlightCard(flightViewModel: FlightViewModel(flight: erroneousMockFlight),),
      );

      await tester.pumpWidget(widget);

      expect(find.text('Unknown Time'), findsWidgets);
      expect(find.text('Unknown Date'), findsWidgets);
    },
  );
}