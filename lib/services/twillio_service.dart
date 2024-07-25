import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final TwilioFlutter twilioFlutter = TwilioFlutter(
    accountSid: dotenv.env['accountSid']!, 
    authToken: dotenv.env['authToken']!, 
    twilioNumber: dotenv.env['twilioNumber']!, 
);