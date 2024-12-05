import 'dart:io';

import 'package:favorite_places/models/favorite_place.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({required this.place, super.key});
  final FavoritePlace place;

  @override
  Widget build(BuildContext context) {
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
            Image.file(place.img, fit: BoxFit.cover, width: double.infinity)
          ],
        )));
  }
}
