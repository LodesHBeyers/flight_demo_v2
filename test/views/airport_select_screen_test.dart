import 'dart:convert';
import 'package:flight_demo_v2/views/airport_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../services/webservices.mocks.dart';
import '../test_helpers/mock_airports_data.dart';
import '../test_helpers/test_wrapper.dart';

@GenerateMocks([Client])
void main() {
  testWidgets(
    'Given AirportSelectScreen When loading Should display CircularLoadingIndicator',
        (WidgetTester tester) async {
      MockClient client = MockClient();
      when(client.get(any)).thenAnswer((realInvocation) async => Response('', 200));

      Widget widget = TestWrapper(
        child: AirportSelectScreen(client: client),
      );

      await tester.pumpWidget(widget);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Given AirportSelectScreen When loaded Should display Select Airport text',
        (WidgetTester tester) async {
      MockClient client = MockClient();
      when(client.get(any)).thenAnswer((realInvocation) async => Response(jsonEncode(mockAirportData), 200));

      Widget widget = TestWrapper(
        child: AirportSelectScreen(client: client,),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.text('Select Airport'), findsOneWidget);
    },
  );

  testWidgets(
    'Given AirportSelectScreen When exception is thrown Should display Error Loading and button',
        (WidgetTester tester) async {
      MockClient client = MockClient();
      when(client.get(any)).thenAnswer((realInvocation) async => Response(jsonEncode(mockAirportData), 400));

      Widget widget = TestWrapper(
        child: AirportSelectScreen(client: client,),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(find.text('Error Loading'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    },
  );
}
