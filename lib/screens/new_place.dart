import 'package:favorite_places/models/favorite_place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/widget/image_input.dart';
import 'package:favorite_places/widget/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});
  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final formKey = GlobalKey<FormState>();
  var location;
  var title;
  var img;
  void saveTitle() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (img != null) {
        ref.read(placesProvider.notifier).addPlace(
            FavoritePlace(title: title, img: img, location: location));
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: const Text('Add new place'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: TextFormField(
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
                maxLength: 50,
                onSaved: (value) {
                  title = value;
                },
                decoration: const InputDecoration(label: Text('Title')),
                validator: (value) {
                  if (value == null || value.isEmpty || img == null) {
                    return 'Please enter the inputs';
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ImageInput(
              selectedImg: (image) {
                img = image;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LocationInput(
              onSelectedLocation: (loc) {
                location = loc;
              },
            ),
          ),
          const SizedBox(height: 5),
          ElevatedButton.icon(
            onPressed: saveTitle,
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
          )
        ],
      ),
    );
  }
}
