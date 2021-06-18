import 'dart:convert';

import 'package:flight_demo_v2/models/airport_model.dart';
import 'package:flight_demo_v2/models/flight_model.dart';
import 'package:flight_demo_v2/services/web_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../test_helpers/mock_airports_data.dart';
import '../test_helpers/mock_flights_data.dart';
import 'webservices.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  group(
    'Flights api interaction',
    () {
      test(
        'Given a call to fetchFlights When error code is returned Should throw an exception',
        () async {
          when(mockClient.get(any))
              .thenAnswer((realInvocation) async => http.Response('', 404));

          final result = WebServices.fetchFlights(client: mockClient, iataCode: '');

          expect(result, throwsException);
        },
      );

      test(
        'Given a call to fetchFlights When no error code is returned Should return a list of flights',
        () async {
          when(mockClient.get(any)).thenAnswer((realInvocation) async =>
              http.Response(jsonEncode(mockFlightsData), 200));

          final result = await WebServices.fetchFlights(client: mockClient, iataCode: '');

          expect(result, isA<List<Flight>>());
        },
      );

      test(
        'Given a call to fetchMoreFlights When error code is returned Should throw an exception',
            () async {
          when(mockClient.get(any))
              .thenAnswer((realInvocation) async => http.Response('', 404));

          final result = WebServices.fetchMoreFlights(client: mockClient, iataCode: '', offset: 0);

          expect(result, throwsException);
        },
      );

      test(
        'Given a call to fetchMoreFlights When no error code is returned Should return a list of flights',
            () async {
          when(mockClient.get(any)).thenAnswer((realInvocation) async =>
              http.Response(jsonEncode(mockFlightsData), 200));

          final result = await WebServices.fetchMoreFlights(client: mockClient, iataCode: '', offset: 0);

          expect(result, isA<List<Flight>>());
        },
      );
    },
  );

  group(
    'Airports api interaction',
      (){
        test(
          'Given a call to fetchAirports When error code is returned Should throw an exception',
              () async {
            when(mockClient.get(any))
                .thenAnswer((realInvocation) async => http.Response('', 404));

            final result = WebServices.fetchAirports(client: mockClient);

            expect(result, throwsException);
          },
        );

        test(
          'Given a call to fetchAirports When no error code is returned Should return a list of airports',
              () async {
            when(mockClient.get(any)).thenAnswer((realInvocation) async =>
                http.Response(jsonEncode(mockAirportData), 200));

            final result = await WebServices.fetchAirports(client: mockClient);

            expect(result, isA<List<Airport>>());
          },
        );
      },
  );
}
