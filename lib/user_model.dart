import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class UserModel {
  String? fullName;
  String? gender;
  Timestamp? dob;
  BloodModel? bloodType;
  int? weight;
  DivisionModel? divisionModel;
  DistrictModel? districtModel;
  UpazilaModel? upazilaModel;
  UnionModel? unionModel;
  String? address;
  String? phone;
  double? lat;
  double? long;
  String? docID;
  int? totalDonation;
  bool? activeDonor;
  String? avatar;
  Timestamp? createdAt;
  Timestamp? lastDonated;
  String? fcmToken;
  DonationStatus? userStatus;
  List<DonationModel>? bloodRequests;
  List<DonationModel>? bloodDonations;

  UserModel({
    this.fullName,
    this.gender,
    this.dob,
    this.bloodType,
    this.weight,
    this.divisionModel,
    this.districtModel,
    this.upazilaModel,
    this.unionModel,
    this.address,
    this.lastDonated,
    this.phone,
    this.lat,
    this.long,
    this.docID,
    this.totalDonation = 0,
    this.activeDonor = true,
    this.avatar,
    this.createdAt,
    this.userStatus,
    this.bloodDonations,
    this.bloodRequests,
    this.fcmToken,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userStatus = json['userStatus'] == null
        ? DonationStatus.pending
        : json['userStatus'] == "completed"
            ? DonationStatus.completed
            : json['userStatus'] == "pending"
                ? DonationStatus.pending
                : json['userStatus'] == "accepted"
                    ? DonationStatus.accepted
                    : json['userStatus'] == "booked"
                        ? DonationStatus.booked
                        : DonationStatus.cancelled;

    fullName = json['fullName'];
    gender = json['gender'];
    dob = json['dob'];
    bloodType = json['bloodType'] != null
        ? BloodModel.fromJson(json['bloodType'])
        : null;
    fcmToken = json['fcmToken'];
    weight = json['weight'];
    divisionModel = json['division'] != null
        ? DivisionModel.fromJson(json['division'])
        : null;
    districtModel = json['district'] != null
        ? DistrictModel.fromJson(json['district'])
        : null;
    upazilaModel =
        json['upazila'] != null ? UpazilaModel.fromJson(json['upazila']) : null;
    unionModel =
        json['union'] != null ? UnionModel.fromJson(json['union']) : null;
    address = json['address'];
    phone = json['phone'];
    lat = json['lat'];
    long = json['long'];
    docID = json['docID'];
    totalDonation = json['totalDonation'];
    activeDonor = json['activeDonor'];
    avatar = json['avatar'];
    createdAt = json['createdAt'];
    lastDonated = json['lastDonated'];
    bloodDonations = json['bloodDonations'] != null
        ? json["bloodDonations"]
            .map<DonationModel>((e) => DonationModel.fromJson(e))
            .toList()
        : [];
    bloodRequests = json['bloodRequests'] != null
        ? json["bloodRequests"]
            .map<DonationModel>((e) => DonationModel.fromJson(e))
            .toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userStatus'] = userStatus!.toShortString();
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['dob'] = dob;
    if (bloodType != null) {
      data['bloodType'] = bloodType!.toJson();
    }
    data['weight'] = weight;
    data['division'] = divisionModel!.toJson();
    data['district'] = districtModel!.toJson();
    data['upazila'] = upazilaModel!.toJson();
    data['union'] = unionModel!.toJson();
    data['address'] = address;
    data['phone'] = phone;
    data['lat'] = lat;
    data['long'] = long;
    data['docID'] = docID;
    data['totalDonation'] = totalDonation;
    data['activeDonor'] = activeDonor;
    data['avatar'] = avatar;
    data['createdAt'] = createdAt;
    data['fcmToken'] = fcmToken;
    data['lastDonated'] = lastDonated;
    if (bloodDonations != null) {
      data['bloodDonations'] = bloodDonations!.map((e) => e.toJson()).toList();
    }
    if (bloodRequests != null) {
      data['bloodRequests'] = bloodRequests!.map((e) => e.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toJsonUpdateProfile() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['fullName'] = fullName;
    data['gender'] = gender;
    data['dob'] = dob;
    if (bloodType != null) {
      data['bloodType'] = bloodType!.toJson();
    }
    data['weight'] = weight;
    data['division'] = divisionModel!.toJson();
    data['district'] = districtModel!.toJson();
    data['upazila'] = upazilaModel!.toJson();
    data['union'] = unionModel!.toJson();
    data['address'] = address;

    return data;
  }

// Map<String, dynamic> toJsonComplete() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//    data['lastDonated'] = Timestamp.now();
//   return data;
// }
}

BloodModel bloodModelFromJson(String str) =>
    BloodModel.fromJson(json.decode(str));

class BloodModel {
  int? id;
  String? title;

  BloodModel({
    this.id,
    this.title,
  });

  BloodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class DivisionModel {
  int? id;
  String? title;

  DivisionModel({this.id, this.title});

  DivisionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class DistrictModel {
  int? divisionID;
  int? id;
  String? title;

  DistrictModel({this.divisionID, this.id, this.title});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    divisionID = json['divisionID'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['divisionID'] = divisionID;
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class UpazilaModel {
  int? districtID;
  int? divisionID;
  int? id;
  String? title;

  UpazilaModel({this.divisionID, this.id, this.title, this.districtID});

  UpazilaModel.fromJson(Map<String, dynamic> json) {
    districtID = json['districtID'];
    divisionID = json['divisionID'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['divisionID'] = divisionID;
    data['districtID'] = districtID;
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class UnionModel {
  int? districtID;
  int? divisionID;
  int? id;
  String? title;

  UnionModel({this.divisionID, this.id, this.title, this.districtID});

  UnionModel.fromJson(Map<String, dynamic> json) {
    districtID = json['districtID'];
    divisionID = json['divisionID'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['divisionID'] = divisionID;
    data['districtID'] = districtID;
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

enum DonationStatus { pending, booked, accepted, cancelled, completed, expired }

extension ParseToString on DonationStatus {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class DonationModel {
  String? docID;
  String? bloodRequestDocID;
  UserDonationStatus? requesterStatus;
  UserDonationStatus? donorStatus;
  Timestamp? createdAt;

  DonationModel({
    this.docID,
    this.bloodRequestDocID,
    this.requesterStatus,
    this.donorStatus,
    this.createdAt,
  });

  DonationModel.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    bloodRequestDocID = json['bloodRequestDocID'];
    requesterStatus = UserDonationStatus.fromJson(json['requesterStatus']);
    donorStatus = UserDonationStatus.fromJson(json['donorStatus']);
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['docID'] = docID;
    data['bloodRequestDocID'] = bloodRequestDocID;
    if (requesterStatus != null) {
      data['requesterStatus'] = requesterStatus!.toJson();
    }
    if (donorStatus != null) {
      data['donorStatus'] = donorStatus!.toJson();
    }

    data['createdAt'] = createdAt;
    return data;
  }
}

class UserDonationStatus {
  String? userDocID;
  DonationStatus? donationStatus;
  CompleteNoteModel? note;
  Timestamp? createdAt;

  UserDonationStatus(
      {this.userDocID, this.donationStatus, this.note, this.createdAt});

  UserDonationStatus.fromJson(Map<String, dynamic> json) {
    userDocID = json['userDocID'];
    note = json['note'] != null
        ? CompleteNoteModel.fromJson(json['note'])
        : CompleteNoteModel();
    donationStatus = json['donationStatus'] == "completed"
        ? DonationStatus.completed
        : json['donationStatus'] == "pending"
            ? DonationStatus.pending
            : json['donationStatus'] == "accepted"
                ? DonationStatus.accepted
                : json['donationStatus'] == "booked"
                    ? DonationStatus.booked
                    : json['donationStatus'] == "expired"
                        ? DonationStatus.expired
                        : DonationStatus.cancelled;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userDocID'] = userDocID;
    data['note'] = note;
    data['donationStatus'] = donationStatus!.toShortString();
    data['createdAt'] = Timestamp.now();
    return data;
  }
}

class CompleteNoteModel {
  String? note;
  String? image;
  File? imageFile;
  Timestamp? createdAt;
  String? type;

  CompleteNoteModel(
      {this.note, this.image, this.imageFile, this.type, this.createdAt});

  CompleteNoteModel.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    image = json['image'];
    type = json['type'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['note'] = note;
    data['image'] = image;
    data['type'] = type;
    data['createdAt'] = Timestamp.now();
    return data;
  }
}
