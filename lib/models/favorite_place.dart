import 'package:uuid/uuid.dart';

class FavoritePlace {
  FavoritePlace({required this.title}) : id = const Uuid().v4();
  final String id;
  final String title;
}
