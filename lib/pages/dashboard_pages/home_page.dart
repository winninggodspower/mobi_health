import 'dart:convert';
import 'package:health/health.dart';
import 'dart:developer' as developer;
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:mobi_health/theme.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/services/health_service.dart';
import 'package:mobi_health/svg_assets.dart' as svg_assets;
import 'package:mobi_health/providers/health_data_provider.dart';
import 'package:mobi_health/providers/authentication_provider.dart';
import 'package:mobi_health/pages/dashboard_pages/connect_device.dart';
import 'package:mobi_health/health_connect_settings.dart' as health_settings;
import 'package:mobi_health/pages/dashboard_pages/components/health_card.dart';
import 'package:mobi_health/pages/dashboard_pages/wellness_hub/wellness_hub.dart';
import 'package:mobi_health/pages/dashboard_pages/components/dashboard_profile_notification.dart';

class HomePage extends StatefulWidget {
  final PageController pageController;

  const HomePage({
    super.key,
    required this.pageController,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

enum AppState {
  HORIZED,
  AUTH_NOT_GRANTED,
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
}

class _HomePageState extends State<HomePage> {
  List<HealthDataPoint> _healthDataList = [];

  AppState _state = AppState.DATA_NOT_FETCHED;

  void initState() {
    Health().configure(useHealthConnectIfAvailable: true);
    
    Workmanager().cancelAll();

    // add background task
    Workmanager().registerPeriodicTask(
      '1',
      'fetchHealthData',
      initialDelay: const Duration(seconds: 10),
      frequency: const Duration(minutes: 15),
    );

    super.initState();
  }

  Future<void> fetchData() async {
    setState(() => _state = AppState.FETCHING_DATA);

    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));
    _healthDataList.clear();

    try {
      List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
        types: health_settings.types,
        startTime: yesterday,
        endTime: now,
      );
      developer.log('health data: ${healthData}');
      _healthDataList.addAll(
          (healthData.length < 100) ? healthData : healthData.sublist(0, 100));
    } catch (error) {
      debugPrint("Exception in getHealthDataFromTypes: $error");
    }

    _healthDataList = Health().removeDuplicates(_healthDataList);

    for (var data in _healthDataList) {
      debugPrint(jsonEncode(data));
    }

    setState(() {
      _state = _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    final user = authProvider.user;
    final userInfo = authProvider.userInfo;
    developer.log(userInfo.toString());

    int durationOfPregnancy = calculateCurrentDurationOfPregnancy(
        userInfo?['createdAt'], userInfo?['durationOfPregnancy']);
    developer.log(userInfo.toString());

    // final permissionProvider = context.watch<DevicePermissionProvider>();
    // if (permissionProvider.isAuthorized) {
    //   fetchData();
    // }

    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 39, 18, 34),
          child: ListView(
            children: [
              DashboardProfileNotificationWidget(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Welcome back, ${user?.displayName}!',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Pregnancy week : ${durationOfPregnancy}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.gray),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                '3rd Trimester',
                style: GoogleFonts.alegreya(
                    fontSize: 11.11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray),
              ),
              const SizedBox(
                height: 22,
              ),
              Text(
                'Processed Information',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(
                height: 6,
              ),
              // if(!permissionProvider.isAuthorized)
              //   Column(
              //     children: [
              //       const SizedBox(height: 30,),
              //       ElevatedButton(
              //         onPressed: (){
              //           Navigator.push(context, MaterialPageRoute(builder: (context)=> const HospitalRegisterPage()));
              //           // widget.pageController.jumpToPage(3);
              //           },
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: AppColors.primaryColor,
              //           textStyle: GoogleFonts.alegreyaSans(
              //             fontSize: 16,
              //             fontWeight: FontWeight.w700,
              //           ),
              //         ),
              //         child: Text('authorize health connect'))
              //     ],
              //   )
              // else
              Consumer<HealthDataProvider>(
                  builder: (context, healthDataProvider, child) {
                final healthData = healthDataProvider.healthData;
                if (healthData == null) {
                  return const Center(
                      child: Text('No health data available'));
                }
                return Column(
                  children: [
                    HealthCard(
                      leadingIcon: svg_assets.sleepCircleIcon,
                      title: 'Sleep',
                      subtitle: 'Total hours of sleep',
                      mainValue:
                          '${healthData.sleepHours.toStringAsFixed(1)} hours',
                      statusWidget: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary_200Color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: Text(
                          '12:40 AM - \n 6:50 AM',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 14,
                                color: AppColors.primary_800Color,
                                fontWeight: FontWeight.w700,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Column(
                        children: [
                          HealthCard(
                            leadingIcon: svg_assets.heartCircleIcon,
                            title: 'Heart Rate',
                            subtitle: 'current Heart rate',
                            mainValue: '${healthData.heartRate} bpm',
                            statusWidget: Row(
                              children: [
                                Text(
                                  'Normal',
                                  style: GoogleFonts.alegreya(
                                      fontSize: 13.4,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                SvgPicture.asset(svg_assets.heartIcon)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          HealthCard(
                            leadingIcon: svg_assets.temperatureCircleIcon,
                            title: 'Body Temperature',
                            subtitle: 'current Temperature',
                            mainValue:
                                '${healthData.bodyTemperature.toStringAsFixed(1)}°C',
                            statusWidget: Row(
                              children: [
                                Text(
                                  'Low',
                                  style: GoogleFonts.alegreya(
                                      fontSize: 13.4,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                SvgPicture.asset(svg_assets.temperatureIcon)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          HealthCard(
                            leadingIcon: svg_assets.weightCircleIcon,
                            title: 'Weight',
                            subtitle: 'Recent measurement',
                            mainValue:
                                '${healthData.weight.toStringAsFixed(1)}Kg',
                            statusWidget: Row(
                              children: [
                                Text(
                                  'Low',
                                  style: GoogleFonts.alegreya(
                                      fontSize: 13.4,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary_500Color,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  child: Text(
                                    '-10.5 kg',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          color: AppColors.gray,
                                          fontWeight: FontWeight.w700,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          HealthCard(
                            leadingIcon: svg_assets.stepsCircleIcon,
                            title: 'Steps/Activity',
                            subtitle: 'steps taken today',
                            mainValue: '${healthData.steps} steps',
                            statusWidget: Text(
                              'Low',
                              style: GoogleFonts.alegreya(
                                  fontSize: 13.4,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              })
            ],
          )),
    );
  }
}
