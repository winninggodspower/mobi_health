import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobi_health/pages/authentication/patient_pages/auth_success_page.dart';
import 'package:mobi_health/pages/authentication/patient_pages/otp_page.dart';
import 'package:mobi_health/pages/components/app_label.dart';
import 'package:mobi_health/pages/components/auth_question.dart';
import 'package:mobi_health/theme.dart';
import 'package:mobi_health/util.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var _obscurePassword;
  var _obscureConfirmPassword;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _durationOfPregnancyController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  DateTime? _selectedDateOfBirth;

  DateTime? _dob;

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
      e164Key: "");

  String? selectedHospital;
  List<String> hospitals = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscurePassword = false;
    _obscureConfirmPassword = false;

    fetchHospitals().then((hospitalList) {
      setState(() {
        hospitals = hospitalList;
      });
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<List<String>> fetchHospitals() async {
    List<String> hospitals = [];
    try {
      QuerySnapshot snapshot = await _firestore.collection('hospital').get();
      for (var doc in snapshot.docs) {
        hospitals.add(doc['name']);
      }
    } catch (e) {
      print('Error fetching hospitals: $e');
    }
    return hospitals;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
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
                  Text(
                    'Let’s keep things in place for your successful journey to delivery',
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
                    const AppLabel(textContent:'First Name' ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your first name', // Placeholder text
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const AppLabel(textContent: 'Last Name'),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your last name', // Placeholder text
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const AppLabel(textContent: 'Date of Birth'),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _dateOfBirthController,
                      decoration: InputDecoration(
                          hintText: 'Date of Birth', // Placeholder text
                          prefixIcon: IconButton(
                            onPressed: () async {
                              final DateTime? selectedDate =
                                  await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1980),
                                      lastDate: DateTime(2023));
                              if (selectedDate != null) {
                                final DateFormat formatter =
                                    DateFormat('dd/MM/yyyy');
                                final String formattedDate =
                                    formatter.format(selectedDate);
                                setState(() {
                                  _dateOfBirthController.text = formattedDate;
                                  _selectedDateOfBirth = selectedDate;
                                });
                              }
                            },
                            icon: const Icon(Icons.calendar_month),
                          )),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your date of birth';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const AppLabel(textContent: 'Duration of pregnancy(Optional)'),
                    const SizedBox(height: 14),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _durationOfPregnancyController,
                      decoration: const InputDecoration(
                        hintText:
                            'Estimated date you go pregnant', // Placeholder text
                      ),
                      validator: (value) {
                       if (value == null || value.isEmpty) {
                        return 'This field cannot be empty';
                      }
                      },
                    ),
                    const SizedBox(height: 20),
                    const AppLabel(textContent: "Hospital(Optional)"),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      value: selectedHospital,
                      hint: Text(
                        'Select hospital where you do antinatals',
                        style: Theme.of(context).inputDecorationTheme.hintStyle,
                        ),
                      items: hospitals.map((String hospital) {
                        return DropdownMenuItem<String>(
                          value: hospital,
                          child: Text(
                            hospital,
                            style: Theme.of(context).inputDecorationTheme.hintStyle
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedHospital = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const AppLabel(textContent: 'Phone number'),
                    const SizedBox(height: 14),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '+237xxxxxxxxx',
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
                                const SizedBox(width: 24,),
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
                    const AppLabel(textContent: 'Password'),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                          hintText: 'Set a password', // Placeholder text
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: _obscurePassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        if (value.length < 6) {
                          return 'Password lenght must be more than 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const AppLabel(textContent: 'Confirm Password'),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                          hintText: 'Re-enter password', // Placeholder text
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                            icon: _obscureConfirmPassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          )),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return "password doesn\'t match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 41),
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

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dialog from being dismissed by tapping outside
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    var phoneNumber = "+${selectedCountry.phoneCode}${_phoneController.text}";

    // ensure phone number doesn't start with ++
    phoneNumber = phoneNumber.startsWith('++') ? phoneNumber.substring(1) : phoneNumber;
    log(phoneNumber);

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        Navigator.pop(context);
        ShowSnackBar(context, "error: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificatonPage(
              verificationId: verificationId,
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              dateOfBirth: _selectedDateOfBirth!,
              durationOfPregnancy: int.parse(_durationOfPregnancyController.text),
              hospital: selectedHospital!,
              phoneNumber: phoneNumber,
              password: _passwordController.text,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
