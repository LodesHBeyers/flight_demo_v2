import 'dart:convert';

import 'package:flight_demo_v2/viewmodels/flight_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../services/webservices.mocks.dart';
import '../test_helpers/mock_flights_data.dart';
import '../test_helpers/test_wrapper.dart';

@GenerateMocks([Client])
void main() {
  testWidgets(
    'Given FlightListViewModel When constructed Should contain empty'
        ' flightList',
        (WidgetTester tester) async {
      Widget widget = TestWrapper(
        child: Builder(
          builder: (context) {
            final flightListViewModel =
            Provider.of<FlightListViewModel>(context);

            return Column(
              children: flightListViewModel.flightList
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
    'Given FlightListViewModel When availableFlights called Should '
        'append to flightList',
        (WidgetTester tester) async {
      MockClient mockClient = MockClient();

      when(mockClient.get(any)).thenAnswer((realInvocation) async =>
          Response(jsonEncode(mockFlightsData), 200));

      var initVal;
      var setVal;

      Widget widget = TestWrapper(
        child: Builder(
          builder: (context) {
            final airportListViewModel =
            Provider.of<FlightListViewModel>(context);
            initVal = airportListViewModel.flightList.length;
            return Column(
              children: [
                TextButton(
                  key: Key('button'),
                  onPressed: () async {
                    await airportListViewModel.availableFlights(client: mockClient, iataCode: '');
                    setVal = airportListViewModel.flightList.length;
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

  testWidgets(
    'Given FlightListViewModel When loadMoreFlights called Should '
        'append to flightList',
        (WidgetTester tester) async {
      MockClient mockClient = MockClient();

      when(mockClient.get(any)).thenAnswer((realInvocation) async =>
          Response(jsonEncode(mockFlightsData), 200));

      var initVal;
      var setVal;

      Widget widget = TestWrapper(
        child: Builder(
          builder: (context) {
            final airportListViewModel =
            Provider.of<FlightListViewModel>(context);
            return Column(
              children: [
                TextButton(
                  key: Key('button'),
                  onPressed: () async {
                    await airportListViewModel.availableFlights(client: mockClient, iataCode: '');
                    initVal = airportListViewModel.flightList.length;
                  },
                  child: Text('Button'),
                ),
                TextButton(
                  key: Key('button2'),
                  onPressed: () async {
                    await airportListViewModel.loadMoreFlights(client: mockClient, iataCode: '', offset: 0);
                    setVal = airportListViewModel.flightList.length;
                  },
                  child: Text('Button'),
                )
              ],
            );
          },
        ),
      );

      await tester.pumpWidget(widget);

      await tester.tap(find.byKey(Key('button')));

      expect(initVal, 1);

      await tester.tap(find.byKey(Key('button2')));

      expect(setVal, 2);
    },
  );

  testWidgets(
    'Given FlightListViewModel When emptyFlights called Should '
        'empty flightList',
        (WidgetTester tester) async {
      MockClient mockClient = MockClient();

      when(mockClient.get(any)).thenAnswer((realInvocation) async =>
          Response(jsonEncode(mockFlightsData), 200));

      var initVal;
      var setVal;

      Widget widget = TestWrapper(
        child: Builder(
          builder: (context) {
            final airportListViewModel =
            Provider.of<FlightListViewModel>(context);
            return Column(
              children: [
                TextButton(
                  key: Key('button'),
                  onPressed: () async {
                    await airportListViewModel.availableFlights(client: mockClient, iataCode: '');
                    initVal = airportListViewModel.flightList.length;
                  },
                  child: Text('Button'),
                ),
                TextButton(
                  key: Key('button2'),
                  onPressed: () async {
                    await airportListViewModel.emptyFlights();
                    setVal = airportListViewModel.flightList.length;
                  },
                  child: Text('Button'),
                )
              ],
            );
          },
        ),
      );

      await tester.pumpWidget(widget);

      await tester.tap(find.byKey(Key('button')));

      expect(initVal, 1);

      await tester.tap(find.byKey(Key('button2')));

      expect(setVal, 0);
    },
  );
}