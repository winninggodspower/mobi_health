 import 'package:health/health.dart';

var types = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
    HealthDataType.BODY_TEMPERATURE,
    HealthDataType.WEIGHT,
    HealthDataType.BLOOD_OXYGEN
  ];

List<HealthDataAccess> get permissions =>
    types.map((e) => HealthDataAccess.READ).toList();