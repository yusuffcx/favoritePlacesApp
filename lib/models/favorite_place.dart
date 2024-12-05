import 'dart:io';

import 'package:uuid/uuid.dart';

class FavoritePlace {
  FavoritePlace({required this.img, required this.title})
      : id = const Uuid().v4();
  final String id;
  final String title;
  final File img;
}
