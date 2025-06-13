import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/database/database.dart';
import 'core/models/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalData.initLocalService();
  setupLocator();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  runApp(
    const Application(),
  );
}
