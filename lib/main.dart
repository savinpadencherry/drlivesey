import 'core/locator.dart';
import 'core/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'views/home/home_view.dart';

void main() async {
  await LocatorInjector.setupLocator();
  runApp(const MainApplication());
}

class MainApplication extends StatelessWidget {
  const MainApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: getIt<NavigatorService>().navigatorKey,
      home: const HomeView(),
    );
  }
}
