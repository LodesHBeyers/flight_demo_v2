import 'dart:convert';

import 'package:flight_demo_v2/viewmodels/airport_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../services/webservices.mocks.dart';
import '../test_helpers/mock_airports_data.dart';
import '../test_helpers/test_wrapper.dart';

@GenerateMocks([Client])
void main() {
  testWidgets(
    'Given AirportListViewModel When constructed Should contain empty'
        ' airportList',
        (WidgetTester tester) async {
      Widget widget = TestWrapper(
        child: Builder(
          builder: (context) {
            final airportListViewModel =
            Provider.of<AirportListViewModel>(context);

            return Column(
              children: airportListViewModel.airportList
                  .map((e) => Text('container'))
                  .toList(),
            );
          },
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.text('container'), findsNothing);
    },
  );

  testWidgets(
    'Given AirportListViewModel When availableAirports called Should '
        'append to airportList',
        (WidgetTester tester) async {
      MockClient mockClient = MockClient();

      when(mockClient.get(any)).thenAnswer((realInvocation) async =>
          Response(jsonEncode(mockAirportData), 200));

      var initVal;
      var setVal;

      Widget widget = TestWrapper(
        child: Builder(
          builder: (context) {
            final airportListViewModel =
            Provider.of<AirportListViewModel>(context);
            initVal = airportListViewModel.airportList.length;
            return Column(
              children: [
                TextButton(
                  key: Key('button'),
                  onPressed: () async {
                    await airportListViewModel.availableAirports(client: mockClient);
                    setVal = airportListViewModel.airportList.length;
                  },
                  child: Text('Button'),
                ),
              ],
            );
          },
        ),
      );

      await tester.pumpWidget(widget);

      expect(initVal, 0);

      await tester.tap(find.byKey(Key('button')));

      expect(setVal, 1);
    },
  );
}
