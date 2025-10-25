import 'package:flutter/material.dart';
import 'package:programmes/pages/home.dart';
import 'package:programmes/pages/navigation.dart';
import 'package:programmes/workout/workoutWidget.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/navigation",
  routes: {
    "/navigation": (context) => const Navigation(),
  },
));
