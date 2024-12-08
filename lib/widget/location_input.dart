import 'dart:convert';
import 'package:favorite_places/models/favorite_place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? loc;

  var waitingGetLoc = false;
  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      waitingGetLoc = true;
    });

    locationData = await location.getLocation();
    final lng = locationData.longitude;
    final lat = locationData.latitude;
    if (lng == null || lat == null) {
      return;
    }

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAzpUXdswADNpnJ_8iUhaJViA9KNH2R6as');
    final resp = await http.get(url);
    final data = json.decode(resp.body);
    final address = data['results'][0]['formatted_address'];
    print(address);

    setState(() {
      loc = PlaceLocation(longitude: lng, latitude: lat, address: address);
      waitingGetLoc = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 170,
        decoration: BoxDecoration(
            border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
          width: 1,
        )),
        child: !waitingGetLoc
            ? Text('No location selected',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
                textAlign: TextAlign.center)
            : const SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(),
              ),
      ),
      !waitingGetLoc
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    icon: const Icon(Icons.location_on),
                    onPressed: getCurrentLocation,
                    label: const Text('Get Current Location')),
                ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text('Select on Map'),
                  icon: const Icon(Icons.map),
                )
              ],
            )
          : const ElevatedButton(
              onPressed: null,
              child: SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(),
              ),
            )
    ]);
  }
}
