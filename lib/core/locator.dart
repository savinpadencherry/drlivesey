import 'package:carousel/core/services/http_services.dart';

import '../core/logger.dart';
import '../core/services/navigator_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  // ignore: prefer_final_fields
  static Logger _log = getLogger('LocatorInjector');

  static Future<void> setupLocator() async {
    _log.d('Initializing Services');
    locator.registerLazySingleton(
      () => NavigatorService(),
    );
    locator.registerLazySingleton(
      () => HttpService(),
    );
  }
}
