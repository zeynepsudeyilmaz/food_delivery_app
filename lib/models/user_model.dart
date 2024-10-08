import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String email;
  final String name;
  final String phoneNumber;
  final String birthDate;
  final DateTime? createdDate;

  UserModel({
    this.uid,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.birthDate,
    this.createdDate,
  });

  // Firestore'dan veri almak için fromMap metodu
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      birthDate: data['birthDate'],
      createdDate: (data['createdDate'] as Timestamp?)?.toDate(),
    );
  }

  // Firestore'a veri yazmak için toMap metodu
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate,
      'createdDate': createdDate ?? FieldValue.serverTimestamp(),
    };
  }
}
