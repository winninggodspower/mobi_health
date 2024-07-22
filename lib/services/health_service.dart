import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobi_health/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthDataService {
  final BuildContext context;
  late NotificationService _notificationService;

  HealthDataService({required this.context}){
    _notificationService = NotificationService(context: context);
  }

  HealthData fetchHealthData() {
    HealthData mockData = generateMockHealthData();
    _checkHealthData(mockData);

    // Save the new data to SharedPreferences
    saveHealthData(mockData.toJson());
    return mockData;
  }

  Future<void> saveHealthData(Map<String, dynamic> healthData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('healthData', jsonEncode(healthData));
  }

  Future<HealthData?> getHealthData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? healthDataString = prefs.getString('healthData');
    if (healthDataString != null) {
      return HealthData.fromJson(jsonDecode(healthDataString));
    }
    return null;
  }

  void _checkHealthData(HealthData data) {
    if (data.steps < 3000 || data.steps > 10000) {
      _notificationService.showNotification(
        'Health Alert',
        'Your step count is outside the normal range.',
      );
    }
    if (data.heartRate < 60 || data.heartRate > 100) {
      _notificationService.showNotification(
        'Health Alert',
        'Your heart rate is outside the normal range.',
      );
    }
    if (data.bodyTemperature < 35.0 || data.bodyTemperature > 38.0) {
      _notificationService.showNotification(
        'Health Alert',
        'Your body temperature is outside the normal range.',
      );
    }
    if (data.sleepHours < 6.0 || data.sleepHours > 9.0) {
      _notificationService.showNotification(
        'Health Alert',
        'Your sleep hours are outside the normal range.',
      );
    }
    if (data.weight < 50.0 || data.weight > 100.0) {
      _notificationService.showNotification(
        'Health Alert',
        'Your weight is outside the normal range.',
      );
    }
  }
}


int calculateCurrentDurationOfPregnancy(Timestamp createdAt, int initialDurationInWeeks) {
  // Convert the Firestore Timestamp to DateTime
  DateTime createdAtDate = createdAt.toDate();

  // Convert the initial duration from weeks to days
  int initialDurationInDays = initialDurationInWeeks * 7;

  // Calculate the difference in days between the current date and the user creation date
  int daysSinceCreation = DateTime.now().difference(createdAtDate).inDays;

  // Calculate the current duration of pregnancy
  int currentDurationInDays = initialDurationInDays + daysSinceCreation;

  // Convert the current duration back to weeks
  int currentDurationInWeeks = currentDurationInDays ~/ 7;

  return currentDurationInWeeks;
}

class HealthData {
  final DateTime date;
  final int steps;
  final int heartRate;
  final double bodyTemperature;
  final double sleepHours;
  final double weight;

  HealthData({
    required this.date,
    required this.steps,
    required this.heartRate,
    required this.bodyTemperature,
    required this.sleepHours,
    required this.weight,
  });

    Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'steps': steps,
      'heartRate': heartRate,
      'bodyTemperature': bodyTemperature,
      'sleepHours': sleepHours,
      'weight': weight,
    };
  }

  factory HealthData.fromJson(Map<String, dynamic> json) {
    return HealthData(
      date: DateTime.parse(json['date']),
      steps: json['steps'],
      heartRate: json['heartRate'],
      bodyTemperature: json['bodyTemperature'],
      sleepHours: json['sleepHours'],
      weight: json['weight'],
    );
  }
}

HealthData generateMockHealthData() {
  var random = Random();
  return HealthData(
    date: DateTime.now(),
    steps: 5000 + random.nextInt(5000),
    heartRate: 60 + random.nextInt(40),
    bodyTemperature: 36.0 + random.nextDouble() * 2.0,
    sleepHours: 4.0 + random.nextDouble() * 4.0,
    weight: 60.0 + random.nextDouble() * 40.0,
  );
}
