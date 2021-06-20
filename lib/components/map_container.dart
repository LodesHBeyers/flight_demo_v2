
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsContainer extends StatelessWidget {
  const MapsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(23.455, -23.455)
      ),
    );
  }
}



