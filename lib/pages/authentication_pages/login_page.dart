import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/pages/components/app_label.dart';
import 'package:mobi_health/pages/components/auth_question.dart';
import 'package:mobi_health/pages/dashboard_pages/dashboard.dart';
import 'package:mobi_health/pages/dashboard_pages/home_page.dart';
import 'package:mobi_health/theme.dart';
import 'package:mobi_health/util.dart';

// class OnBoarding extends StatelessWidget

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 75, 18, 60),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  "Welcome back,",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 32.0,
                        color: Colors.black
                      ),
                ),
                const SizedBox(height: 58),
                const AppLabel(textContent: 'Phone'),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Enter phone number',
                    fillColor:AppColors.grayLight
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const AppLabel(textContent: 'Password'),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      fillColor: AppColors.grayLight,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 62),
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: GoogleFonts.alegreyaSans(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 52, vertical: 21),
                  ),
                  onPressed: handleSubmit,
                  child: const Text('Next'),
                ),
                const SizedBox(height: 14),
                const authQuestion(
                  question_text: 'Don’t have an account yet ?', 
                  action_text: 'sign up',
                  redirect_route: '/register', 
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  void handleSubmit() async {
    final _auth = FirebaseAuth.instance; 
    final _firestore = FirebaseFirestore.instance;

    if (_formKey.currentState?.validate() ?? true) {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: '${_phoneController.text}@example.com', // Use email format based on phone number
        password: _passwordController.text,
      );

      // Check if user credential is not null and navigate to dashboard
      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardIndex()),
        );
      } else {
        ShowSnackBar(context, 'Failed to sign in');
      }
    }
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const DashboardIndex()));
  }
}