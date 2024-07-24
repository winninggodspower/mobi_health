import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobi_health/pages/authentication/hospital_pages/otp_page.dart';
import 'package:mobi_health/pages/components/app_label.dart';
import 'package:mobi_health/pages/components/auth_question.dart';
import 'package:mobi_health/theme.dart';
import 'package:mobi_health/util.dart';

class HospitalRegisterPage extends StatefulWidget {
  const HospitalRegisterPage({super.key});

  @override
  State<HospitalRegisterPage> createState() => _HospitalRegisterPageState();
}

class _HospitalRegisterPageState extends State<HospitalRegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _hospitalNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

    Country selectedCountry = Country(
      phoneCode: "+237",
      countryCode: 'CMR',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'cameroon',
      example: "Cameroon",
      displayName: "Cameroon",
      displayNameNoCountryCode: "CMR",
      e164Key: ""
    );

  @override
  void dispose() {
    _hospitalNameController.dispose();
    _lastNameController.dispose();
    _regionController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary_500Color,
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(18, 75, 18, 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create an Account',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.customWhite,
                        ),
                  ),
                  const SizedBox(
                    width: 20.0,
                    height: 5.71,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(
                        color: AppColors.secondary_700Color
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    'Easily connect to your clients and help them with their mental health remotely',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(23),
                decoration: const BoxDecoration(
                  color: AppColors.customWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(31.0),
                    topRight: Radius.circular(31.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const AppLabel(textContent:'Hospital Name' ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _hospitalNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your hospital name', // Placeholder text
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your hospital name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const AppLabel(textContent: 'Phone number'),
                    const SizedBox(height: 14),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'xxxxxxxxx',
                        // ignore: avoid_unnecessary_containers, unnecessary_const
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 24, top: 8, right: 24),
                                decoration: const BoxDecoration(
                                    border: Border(
                                  right: BorderSide(
                                    color: Color(0xFF8292AA),
                                    width: 0.87,
                                  ),
                                )),
                                child: InkWell(
                                  onTap: () {
                                    showCountryPicker(
                                        context: context,
                                        countryListTheme:
                                            const CountryListThemeData(
                                          bottomSheetHeight: 550,
                                        ),
                                        onSelect: ((value) => {
                                              setState(() {
                                                selectedCountry = value;
                                              })
                                            }));
                                  },
                                  child: Text('${selectedCountry.flagEmoji}'),
                                )),
                                const SizedBox(width: 24),
                          ],
                        ),
                      ),
                      controller: _phoneController,
                      validator: (value) {
                        final phoneRegex = RegExp(r'^\d{1,14}$');
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (!phoneRegex.hasMatch(value)) {
                          return 'Please enter a valid 10-digit phone number';
                        }               
                        return null; 
                      },
                    ),
                    const SizedBox(height: 20),
                    const AppLabel(textContent: 'Region'),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        hintText: 'Select region', // Placeholder text
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please select a region';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const AppLabel(textContent: 'City'),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                          hintText: 'Enter city your hospital is located', // Placeholder text
                        ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        '1/2',
                        style: GoogleFonts.openSans(
                          fontSize: 12,
                          color: AppColors.gray500
                        ),
                      )
                    ),
                    const SizedBox(height: 11),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: GoogleFonts.alegreyaSans(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 52, vertical: 12),
                      ),
                      onPressed: _handleFormSubmit,
                      child: const Text('Next'),
                    ),
                    const authQuestion(
                      question_text: 'Already have an account yet ?', 
                      action_text: 'login',
                      redirect_route: '/login', 
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> _handleFormSubmit() async {
    if (_formKey.currentState != null) {
      if (!_formKey.currentState!.validate()) {
        print('Invalid form');
        return;
        // Handle invalid form case, such as showing error messages
      }
    }
    

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    var phoneNumber = "+${selectedCountry.phoneCode}${_phoneController.text}";

    // ensure phone number doesn't start with ++
    phoneNumber = phoneNumber.startsWith('++') ? phoneNumber.substring(1) : phoneNumber;
    log(phoneNumber);

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
        ShowSnackBar(context, "error: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> HospitalOtpVerificationPage(
            verificationId: verificationId,
            hospitalName: _hospitalNameController.text, 
            phoneNumber: phoneNumber, 
            region: _regionController.text, 
            city: _cityController.text)
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
