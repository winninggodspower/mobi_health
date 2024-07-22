import 'package:flutter/material.dart';

class DevicePermissionProvider with ChangeNotifier {
  bool _isAuthorized = false;

  bool get isAuthorized => _isAuthorized;

  void setAuthorization(bool authorized) {
    _isAuthorized = authorized;
    notifyListeners();
  }
}


// if the icon on the dashBoard is clicked
class DashboardAction with ChangeNotifier {
  bool _isTrue = false;

  bool get value => _isTrue;

  void toggleValue() {
    _isTrue = !_isTrue;
    notifyListeners();
  }
}