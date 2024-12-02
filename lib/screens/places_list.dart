import 'package:favorite_places/models/favorite_place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/new_place.dart';
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

    List<FavoritePlace> places = ref.watch(placesProvider);
    Widget content = places.isEmpty
        ? Center(
            child: Text(
            'No places added yet',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ))
        : ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, int index) {
              return ListTile(
                title: Text(places[index].title),
              );
            },
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
