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
  Widget? map;
  var gettingLoc = false;
  var showMap = false;

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
      gettingLoc = true;
      showMap = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    print(locationData.latitude);
    print(locationData.longitude);
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAzpUXdswADNpnJ_8iUhaJViA9KNH2R6as');
    var resp = await http.get(url);
    print(resp);
    print(resp.body);

    var data = json.decode(resp.body);

    var address = data["results"][0];
    print(address);

    map = Image.network(
        'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=400x400&markers=color:red%7Clabel:G%7C$lat,$lng&maptype=roadmap&key=AIzaSyAzpUXdswADNpnJ_8iUhaJViA9KNH2R6as',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity);

    setState(() {
      gettingLoc = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? content;
    if (!gettingLoc) {
      content = !showMap
          ? Text('No location selected',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
              textAlign: TextAlign.center)
          : map;
    } else {
      content = const SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(),
      );
    }

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
          child: content),
      !gettingLoc
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
