import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lookea/local_data/local_data.dart';
import 'package:lookea/lookea.dart';
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Admob.initialize();

  await LocalData.db.initDB();

  runApp(LookeaRouter());
}