import 'package:favorite_places/models/favorite_place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({super.key, this.location, this.isSelected = false});
  final PlaceLocation? location;
  final bool? isSelected;

  @override
  State<StatefulWidget> createState() {
    return _MapState();
  }
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    var lat = widget.location!.latitude;
    var lng = widget.location!.longitude;
    return Scaffold(
        appBar: AppBar(
            title: widget.isSelected == false
                ? const Text('Select a Location')
                : const Text('Your Location')),
        body: GoogleMap(
            initialCameraPosition: widget.location == null
                ? const CameraPosition(
                    target: LatLng(37.43296265331129, -122.08832357078792))
                : CameraPosition(target: LatLng(lat, lng))));
  }
}
