import 'package:flight_demo_v2/components/map_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../test_helpers/test_wrapper.dart';

void main() {
  testWidgets(
    'Given MapsContainer When rendered Should display GoogleMap',
        (WidgetTester tester) async {
      Widget widget = TestWrapper(
        child: MapsContainer(arrivalLatLng: LatLng(22.23, 44.4456), departureLatLng: LatLng(22.23, 44.4456),),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(GoogleMap), findsOneWidget);
    },
  );
}