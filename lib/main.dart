import 'package:flutter/material.dart';
import 'package:programmes/pages/navigation.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/navigation",
  routes: {
    "/navigation": (context) => Navigation(),
  },
));
