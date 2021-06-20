import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsContainer extends StatefulWidget {
  final LatLng departureLatLng;
  final LatLng arrivalLatLng;

  const MapsContainer(
      {Key? key, required this.departureLatLng, required this.arrivalLatLng})
      : super(key: key);

  @override
  _MapsContainerState createState() => _MapsContainerState();
}

class _MapsContainerState extends State<MapsContainer> {
  final Set<Polyline> _polyline = {};
   GoogleMapController? _controller;
  late LatLng northEast;
  late LatLng southWest;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    Future.delayed(Duration(milliseconds: 400), (){
      _controller?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: widget.arrivalLatLng, zoom: 9)
      ));
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  void getBounds(){
    double highestLong;
    double furthestLat;
    double lowerLong;
    double closerLat;

    if(widget.departureLatLng.longitude > widget.arrivalLatLng.longitude){
      highestLong = widget.departureLatLng.longitude;
      lowerLong = widget.arrivalLatLng.longitude;
    }else{
      highestLong = widget.arrivalLatLng.longitude;
      lowerLong = widget.departureLatLng.longitude;
    }

    if(widget.departureLatLng.latitude > widget.arrivalLatLng.latitude){
      furthestLat = widget.departureLatLng.latitude;
      closerLat = widget.arrivalLatLng.latitude;
    }else{
      furthestLat = widget.arrivalLatLng.latitude;
      closerLat = widget.departureLatLng.latitude;
    }
    northEast = LatLng(highestLong, furthestLat);
    southWest = LatLng(lowerLong, closerLat);
  }

  @override
  Widget build(BuildContext context) {
    _polyline.add(
      Polyline(
          polylineId: PolylineId('newPos'),
          visible: true,
          points: [widget.departureLatLng, widget.arrivalLatLng],
          color: Colors.blue,
          width: 2),
    );

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.departureLatLng,
        zoom: 4.5,
      ),
      onMapCreated: _onMapCreated,
      polylines: _polyline,
    );
  }
}
