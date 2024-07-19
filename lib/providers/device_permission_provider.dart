import 'package:flutter/material.dart';

class DevicePermissionProvider with ChangeNotifier {
  bool _isAuthorized = false;

  bool get isAuthorized => _isAuthorized;

  void setAuthorization(bool authorized) {
    _isAuthorized = authorized;
    notifyListeners();
  }
}
