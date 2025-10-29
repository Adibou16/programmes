import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'images.g.dart';

@HiveType(typeId: 2)
class Images {
  @HiveField(0)
  String name;

  @HiveField(1)
  Uint8List image;

  Images({
    required this.name, 
    required this.image, 
  });
}