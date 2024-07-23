import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobi_health/services/health_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthDataProvider extends ChangeNotifier {
  HealthData? _healthData;

  HealthDataProvider() {
    initializeHealthData();
  }

  HealthData? get healthData => _healthData;

  void setHealthData(HealthData data) {
    _healthData = data;
    notifyListeners();
  }

  Future<void> initializeHealthData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? healthDataString = prefs.getString('healthData');
    if (healthDataString != null) {
      setHealthData(HealthData.fromJson(jsonDecode(healthDataString)));
    } else {
      fetchHealthData();
    }
  }


  void fetchHealthData() {
    HealthData mockData = generateMockHealthData();
    setHealthData(mockData);

    // check health data and send notification if needed
    checkHealthData(mockData);

    // Save the new data to SharedPreferences
    saveHealthData(mockData.toJson());
  }

  Future<void> saveHealthData(Map<String, dynamic> healthData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('healthData', jsonEncode(healthData));
  }

}