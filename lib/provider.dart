import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());

class UserProvider extends ChangeNotifier {
  // final FirebaseServices _firebaseServices = FirebaseServices();
  StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>();
  final List<DocumentSnapshot> _users = [];

  bool _isRequesting = false;
  bool _isFinish = false;

  void initiateData() {
    FirebaseFirestore.instance
        .collection('users')
        .orderBy("fullName", descending: false)
        .snapshots()
        .listen((event) {
      onChangeData(event.docChanges);
      requestNextPage();
    });
  }

  void onChangeData(List<DocumentChange> documentChanges) {
    var isChange = false;
    for (var userChanged in documentChanges) {
      // print(
      //     "User Changed ${userChanged.type}--${userChanged.newIndex}--${userChanged.oldIndex} ${userChanged.doc}");

      if (userChanged.type == DocumentChangeType.removed) {
        _users.removeWhere((user) => userChanged.doc.id == user.id);
        isChange = true;
      } else if (userChanged.type == DocumentChangeType.modified) {
        int indexWhere =
            _users.indexWhere((user) => userChanged.doc.id == user.id);
        if (indexWhere >= 0) {
          _users[indexWhere] = userChanged.doc;
        }
        isChange = true;
      }
    }

    if (isChange) {
      streamController.add(_users);
    }
  }

  void requestNextPage() async {
    if (!_isRequesting && !_isFinish) {
      QuerySnapshot querySnapshot;
      _isRequesting = true;
      if (_users.isEmpty) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .orderBy("fullName", descending: false)
            .limit(15)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .orderBy("fullName", descending: false)
            .startAfterDocument(_users[_users.length - 1])
            .limit(15)
            .get();
      }

      int oldSize = _users.length;
      _users.addAll(querySnapshot.docs);
      int newSize = _users.length;
      if (oldSize != newSize) {
        streamController.add(_users);
      } else {
        _isFinish = true;
      }
      _isRequesting = false;
    }
  }
}
