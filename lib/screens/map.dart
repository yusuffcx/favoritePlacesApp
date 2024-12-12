import 'package:favorite_places/models/favorite_place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.location, this.isSelected = true});
  final PlaceLocation? location;
  final bool? isSelected;

  @override
  State<StatefulWidget> createState() {
    return _MapState();
  }
}

class _MapState extends State<MapScreen> {
  LatLng? selectedLoc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.isSelected == false
              ? const Text('Select a Location')
              : const Text('Your Location'),
          actions: [
            if (widget.isSelected == false)
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(selectedLoc);
                  },
                  icon: const Icon(Icons.add_location))
          ],
        ),
        body: GoogleMap(
            onTap: (pos) {
              if (widget.isSelected == false) {
                setState(() {
                  selectedLoc = pos;
                });
              }
            },
            markers: {
              if (selectedLoc == null)
                Marker(
                    markerId: const MarkerId('D'),
                    position: widget.location == null
                        ? const LatLng(37.43296265331129, -122.08832357078792)
                        : LatLng(widget.location!.latitude,
                            widget.location!.longitude))
              else
                Marker(
                    markerId: const MarkerId('M'),
                    position:
                        LatLng(selectedLoc!.latitude, selectedLoc!.longitude))
            },
            initialCameraPosition: widget.location == null
                ? const CameraPosition(
                    zoom: 16,
                    target: LatLng(37.43296265331129, -122.08832357078792))
                : CameraPosition(
                    zoom: 16,
                    target: LatLng(widget.location!.latitude,
                        widget.location!.longitude))));
  }
}
