//import 'dart:io';
import 'package:favorite_places/models/favorite_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesNotifier extends StateNotifier<List<FavoritePlace>> {
  FavoritePlacesNotifier() : super([]);

  void addPlace(FavoritePlace place) {
    state = [...state, place];
  }
}

final placesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<FavoritePlace>>(
        (ref) => FavoritePlacesNotifier());
