
import 'package:workmanager/workmanager.dart';

class BackgroundService {

  void init(Function callbackDispatcher) {
    print('workmanager initializer was called');
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true
    );
  }
  
}