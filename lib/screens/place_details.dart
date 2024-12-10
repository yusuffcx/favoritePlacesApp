import 'dart:io';

import 'package:favorite_places/models/favorite_place.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({required this.place, super.key});
  final FavoritePlace place;

  @override
  Widget build(BuildContext context) {
    var lat = place.location.latitude;
    var lng = place.location.longitude;
    var map = Image.network(
        'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=400x400&markers=color:red%7Clabel:G%7C$lat,$lng&maptype=roadmap&key=AIzaSyAzpUXdswADNpnJ_8iUhaJViA9KNH2R6as',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity);
    //List<>
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: const Text('Place detail'),
      ),
      body: Center(
        child: Stack(
          children: [
            Image.file(
              place.img,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=400x400&markers=color:red%7Clabel:G%7C$lat,$lng&maptype=roadmap&key=AIzaSyAzpUXdswADNpnJ_8iUhaJViA9KNH2R6as',
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black54])),
                  child: Text(
                    place.location.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
