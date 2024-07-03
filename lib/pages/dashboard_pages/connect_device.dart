import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/pages/dashboard_pages/components/bottom_navigation.dart';
import 'package:mobi_health/pages/dashboard_pages/components/health_card.dart';
import 'package:mobi_health/svg_assets.dart' as svg_assets;
import 'package:mobi_health/theme.dart';

class ConnectDevicePage extends StatefulWidget {
  const ConnectDevicePage({super.key});

  @override
  State<ConnectDevicePage> createState() => _ConnectDevicePageState();
}

class _ConnectDevicePageState extends State<ConnectDevicePage> {
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
                onPressed: () {
                  
                },
                child: const Text('Connect to Google Health'),
              ),
            ),
          ],
        )
      ),
    );
  }
}
