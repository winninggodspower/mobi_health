
import 'package:cloud_firestore/cloud_firestore.dart';

int calculateCurrentDurationOfPregnancy(Timestamp createdAt, int initialDurationInWeeks) {
  // Convert the Firestore Timestamp to DateTime
  DateTime createdAtDate = createdAt.toDate();

  // Convert the initial duration from weeks to days
  int initialDurationInDays = initialDurationInWeeks * 7;

  // Calculate the difference in days between the current date and the user creation date
  int daysSinceCreation = DateTime.now().difference(createdAtDate).inDays;

  // Calculate the current duration of pregnancy
  int currentDurationInDays = initialDurationInDays + daysSinceCreation;

  // Convert the current duration back to weeks
  int currentDurationInWeeks = currentDurationInDays ~/ 7;

  return currentDurationInWeeks;
}