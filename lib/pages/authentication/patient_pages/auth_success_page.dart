import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_health/pages/authentication/patient_pages/login_page.dart';
import 'package:mobi_health/theme.dart';

class OtpSuccessPage extends StatefulWidget {
  const OtpSuccessPage({super.key});

  @override
  State<OtpSuccessPage> createState() => _OtpSuccessPageState();
}

class _OtpSuccessPageState extends State<OtpSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 11,),
              Center(child: Image.asset('assets/circle-check.png')),
              const SizedBox(height: 24,),
              Text(
                'Authentication Complete',
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  color: AppColors.primary_500Color
                ),
              ),
              const SizedBox(height: 41,),
              SizedBox(
                width: 290,
                child: Text(
                  'Phone number has been verified. You can now login to your account',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 73,),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  backgroundColor: AppColors.primary_500Color
                 ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                }, 
                child: Text(
                  'Go to Login',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Colors.white
                  ),
                  )
                )
            ],
          ),
        ),
      ),
    );
  }
}