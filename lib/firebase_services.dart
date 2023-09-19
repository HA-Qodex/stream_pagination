import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_model.dart';

class FirebaseServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference? userCollection;

  FirebaseServices() {
    userCollection = _db.collection('users');
  }

  Stream<List<UserModel>> getUsers() {
    try {
      Stream<QuerySnapshot> stream =
      userCollection!.orderBy("fullName", descending: false).snapshots();

      Stream<List<UserModel>> list =
      stream.map((qShot) => qShot.docs.map<UserModel>((e) {
        return UserModel.fromJson(e.data() as Map<String, dynamic>);
      }).toList());
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }
}
