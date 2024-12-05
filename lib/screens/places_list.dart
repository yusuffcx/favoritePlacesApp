import 'dart:io';

import 'package:favorite_places/models/favorite_place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void addNewPlace() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const NewPlace()));
    }

    void placeDetail(FavoritePlace place) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => PlaceDetails(place: place)));
    }

    List<FavoritePlace> places = ref.watch(placesProvider);
    Widget content = places.isEmpty
        ? Center(
            child: Text(
            'No places added yet',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ))
        : InkWell(
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(places[index].img),
                  ),
                  onTap: () {
                    placeDetail(places[index]);
                  },
                  title: Text(
                    places[index].title,
                  ),
                );
              },
            ),
          );

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          title: const Text('Your Places'),
          actions: [
            IconButton(onPressed: addNewPlace, icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }
}
