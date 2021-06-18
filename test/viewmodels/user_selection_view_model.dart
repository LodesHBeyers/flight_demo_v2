import 'package:flight_demo_v2/viewmodels/airport_view_model.dart';
import 'package:flight_demo_v2/viewmodels/user_selection_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import '../test_helpers/mock_airport.dart';
import '../test_helpers/test_wrapper.dart';

void main() {
  testWidgets(
    'Given UserSelectionViewModel When setSelectedAirport called Should set '
        'selectedAirport',
        (WidgetTester tester) async {

      var changed;

      Widget widget = TestWrapper(
        child: Builder(
          builder: (context) {
            final userSelectionViewModel = Provider.of<UserSelectionViewModel>(
                context);
            return Column(
              children: [
                TextButton(
                  key: Key('button'),
                  onPressed: () {
                    userSelectionViewModel.selectedAirport =
                        AirportViewModel(airport: mockAirport);
                    changed = userSelectionViewModel.selectedAirport.airportName;
                  },
                  child: Text('button'),
                ),
              ],
            );
          },
        ),
      );

      await tester.pumpWidget(widget);

      await tester.tap(find.byKey(Key('button')));

      expect('airportName', changed);

    },
  );
}
