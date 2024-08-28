import 'package:flutter/material.dart';
import 'package:ojo/app/app.dart';

import 'data/helpers/hive_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  runApp(const OjoApp());
}