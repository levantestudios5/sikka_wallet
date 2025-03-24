import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sikka_wallet/di/service_locator.dart';
import 'package:sikka_wallet/presentation/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setPreferredOrientations();
  await ServiceLocator.configureDependencies();

  try {
    await Firebase.initializeApp();
    runApp(MyApp());
  } catch (e) {
    print("Firebase Initialization Error: $e");
  }
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
