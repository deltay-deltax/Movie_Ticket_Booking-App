import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String uid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(userInfoMap, SetOptions(merge: true));
  }
}
