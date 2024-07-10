import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/theme.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:mobi_health/health_connect_settings.dart' as health_settings;
import 'dart:developer' as developer;

enum AppState {
  NOT_INSTALLED,
  AUTHORIZED,
  AUTH_NOT_GRANTED,
}

class ConnectDevicePage extends StatefulWidget {
  const ConnectDevicePage({super.key});

  @override
  State<ConnectDevicePage> createState() => _ConnectDevicePageState();
}

class _ConnectDevicePageState extends State<ConnectDevicePage> {
  AppState _state = AppState.AUTH_NOT_GRANTED;

  void initState() {
    Health().configure(useHealthConnectIfAvailable: true);
    super.initState();
  }

  /// Install Google Health Connect on this phone.
  Future<void> installHealthConnect() async {
    await Health().installHealthConnect();
  }

  Future<void> authorize() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    bool? hasPermissions =
        await Health().hasPermissions(health_settings.types, permissions: health_settings.permissions);
    developer.log('has permission: $hasPermissions');

    bool authorized = hasPermissions ?? false;
    if (hasPermissions != true) {
      try {
        authorized = await Health()
            .requestAuthorization(health_settings.types, permissions: health_settings.permissions);
      } catch (error) {
        developer.log("Exception in authorize: $error");
      }
    }
    developer.log('is it authorized: $authorized');
    setState(() => _state =
        (authorized) ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 39, 18, 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Text(
              'Connection',
              style: GoogleFonts.alegreya(
                  color: AppColors.accentColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 30
                ),
              ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Smart Devices Just For You',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16
                        ),
                    ),
                    const SizedBox(height: 15.0,),
                    Text(
                      'Sleep, heart rate, temperature, oxygen level... Quick access to health data, to keep you and the baby in safe condition',
                      textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14
                          ),
                    ),
                  ],
                )
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  textStyle: GoogleFonts.alegreyaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 52, vertical: 8),
                ),
                onPressed: authorize,
                child: _state == AppState.AUTHORIZED ? 
                const Text('connected to health connect') :
                const Text('Connect to Google Health'),
              ),
            ),
          ],
        )
      ),
    );
  }
}
