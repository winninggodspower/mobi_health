import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/pages/dashboard_pages/action_dropDown/export_action_drop_down.dart';
import 'package:mobi_health/theme.dart';
import 'package:mobi_health/widgets/app_buttons.dart';
import 'package:mobi_health/providers/authentication_provider.dart';
import 'package:mobi_health/providers/health_data_provider.dart';
import 'package:mobi_health/util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ReportEmergencyPopup extends StatefulWidget {
  const ReportEmergencyPopup({super.key});

  @override
  State<ReportEmergencyPopup> createState() => _ReportEmergencyPopupState();
}

class _ReportEmergencyPopupState extends State<ReportEmergencyPopup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emergencyController = TextEditingController();
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      margin:  EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: Colors.blue, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'What is the emergency ?',
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 1.h),
              EmergencyInput(
                borderColor: AppColors.secondaryColor,
                hintText: 'Whats your emergency?',
                textInput: _emergencyController,
                textType: TextInputType.text,
              ),
              SizedBox(height: 0.02.dp),
              SizedBox(
                width: double.infinity,
                height: 6.h,
                child: Row(
                  children: [
                    Checkbox(
                      value: _isSelected,
                      onChanged: (value) {
                        setState(() {
                          _isSelected = value ?? false;
                        });
                      },
                      activeColor: AppColors.secondaryColor,
                      checkColor: AppColors.backgroundColor,
                    ),
                    Text(
                      'Notify my emergency contact',
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              materialButton(
                  buttonBkColor: AppColors.secondaryColor,
                  onPres: () {
                    print('pelar is the king of tiktok');
                    if(_formKey.currentState?.validate() ?? true){
                      _sendEmergencyMessage(_emergencyController.text);
                    }else{
                      print('invalid');
                    }
                  },
                  size: 14,
                  text: "Signal Emergency",
                  textColor: AppColors.backgroundColor,
                  width: 43.w,
                  borderRadiusSize: 5,
                  height: 6.h)
            ],
          ),
        ),
      ),
    );
  }

  _sendEmergencyMessage(emergencyMessage) async {
    final authProvider = context.read<AuthenticationProvider>();
    final healthProvider = context.read<HealthDataProvider>();

    String? emergencyContact = authProvider.userInfo?['emergencyContact'];
    if(emergencyContact == null || emergencyContact.isEmpty) {
      ShowSnackBar(context, 'you haven\'t added an emergency contact');
    }

    final url = Uri.parse('https://mubi-health-func.vercel.app/sendEmergencyContact');

    final Map<String, dynamic> data = {
      "userData": authProvider.userInfo,
      "healthVitals": healthProvider.healthData,
      "emergencyContact": authProvider.userInfo?['emergencyContact'],
      "message": emergencyMessage,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json',},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        // Request was successful
        print('Success: ${response.body}');
      } else {
        // Request failed
        print('Failed: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
    }
  }

}




class EmergencyInput extends StatelessWidget {
  final TextEditingController textInput;
  final String hintText;
  final Color borderColor;
  final TextInputType textType;

  const EmergencyInput({
    Key? key,
    required this.textInput,
    required this.hintText,
    required this.borderColor,
    required this.textType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
        fontSize: 16, fontWeight: FontWeight.w500,);
    return SizedBox(
      height: 100,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: 3,
        controller: textInput,
        style: textStyle,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textStyle,
          filled: true,
          fillColor: AppColors.primary50Color,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor, width: 1.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: borderColor, width: 1.2),
          ),
        ),
        validator: (value){
          if(value?.isEmpty ?? true){
            return 'Please an emergecny message';
          }
          return null;
        },
      ),
    );
  }
}
