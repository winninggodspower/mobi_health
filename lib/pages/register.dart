import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobi_health/pages/authentication_pages/auth_success_page.dart';
import 'package:mobi_health/pages/authentication_pages/otp_page.dart';
import 'package:mobi_health/pages/components/auth_question.dart';
import 'package:mobi_health/theme.dart';
import 'package:mobi_health/util.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _obscurePassword;
  var _obscureConfirmPassword;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscurePassword = false;
    _obscureConfirmPassword = false;
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
                    Text('First Name',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 19.22,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF384252),
                            )),
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
                    Text('Last Name',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 19.22,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF384252),
                            )),
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
                    Text('Date of Birth',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 19.22,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF384252),
                            )),
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
                                      lastDate: DateTime(2024));
                              if (selectedDate != null) {
                                final DateFormat formatter =
                                    DateFormat('dd/MM/yyyy');
                                final String formattedDate =
                                    formatter.format(selectedDate);
                                setState(() {
                                  _dateOfBirthController.text = formattedDate;
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
                    Text('Duration of pregnancy(Optional)',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 19.22,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF384252),
                            )),
                    const SizedBox(height: 14),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText:
                            'Estimated date you go pregnant', // Placeholder text
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text('Hospital(Optional)',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 19.22,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF384252),
                            )),
                    const SizedBox(height: 14),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText:
                            'Select hospital where you do antinatals', // Placeholder text
                      ),
                      controller: _hospitalController,
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text('Phone number',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 19.22,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF384252),
                            )),
                    const SizedBox(height: 14),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '+237,',
                        // ignore: avoid_unnecessary_containers, unnecessary_const
                        prefixIcon: Container(
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
                      ),
                      controller: _phoneController,
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text('Password',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 19.22,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF384252),
                            )),
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
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          )),
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text('Confirm Password',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 19.22,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF384252),
                            )),
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
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          )),
                      validator: (value) {
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
    Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpSuccessPage()));
    return;

    if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("invalid phone number"),
        ));
      return;
    }

    print(selectedCountry.phoneCode + _phoneController.text.toString());
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber:
          "+${selectedCountry.phoneCode}${_phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        ShowSnackBar(context, "error: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpPage(verificationId: verificationId)));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
