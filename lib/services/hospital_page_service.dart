import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> fetchUserIdsWhoMessagedSpecificHospital(String hospitalId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firestore
      .collection('chats')
      .where('receiverType', isEqualTo: 'hospital')
      .where('receiverId', isEqualTo: hospitalId)
      .get();

  Set<String> userIds = querySnapshot.docs
      .map((doc) => doc['senderId'] as String)
      .toSet();

  print(userIds);
  return userIds.toList();
}

Future<List<Map<String, dynamic>>> fetchUserNames(List<String> userIds) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> userNames = [];

  for (String userId in userIds) {
    DocumentSnapshot userDoc = await firestore.collection('users').doc(userId).get();

    if (userDoc.exists) {
      userNames.add({
        'userId': userId,
        'name': userDoc['name'],
      });
    }
  }

  return userNames;
}

Future<List<Map<String, dynamic>>> fetchUsersWhoMessagedSpecificHospital(String hospitalId) async {
  List<String> userIds = await fetchUserIdsWhoMessagedSpecificHospital(hospitalId);
  List<Map<String, dynamic>> userNames = await fetchUserNames(userIds);
  return userNames;
}
