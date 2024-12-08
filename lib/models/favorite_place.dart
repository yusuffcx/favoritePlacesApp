import 'dart:io';
import 'package:uuid/uuid.dart';

class PlaceLocation {
  PlaceLocation(
      {required this.longitude, required this.latitude, required this.address});

  final double longitude;
  final double latitude;
  final String address;
}

class FavoritePlace {
  FavoritePlace({required this.img, required this.title})
      : id = const Uuid().v4();
  final String id;
  final String title;
  final File img;
}
