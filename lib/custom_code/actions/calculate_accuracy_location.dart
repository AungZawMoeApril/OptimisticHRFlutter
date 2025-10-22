// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import 'index.dart'; // Imports other custom actions
import 'package:hr_app/core/utils/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

//import '/actions/actions.dart' as action_blocks;

import 'package:geolocator/geolocator.dart';

Future<int?> calculateAccuracyLocation() async {
  // Add your function code here!
  final geo = Geolocator();
  final location = await Geolocator.getCurrentPosition();
  return location.accuracy.round();
}
