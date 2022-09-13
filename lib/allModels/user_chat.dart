import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ichat_app/allConstants/constants.dart';

class UserChat {
  String id;
  String photoUrl;
  String nickname;
  String aboutMe;
  String phoneNumber;

  UserChat({
    required this.id,
    required this.photoUrl,
    required this.nickname,
    required this.aboutMe,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        FirestoreConstants.nickname: nickname,
        FirestoreConstants.photoUrl: photoUrl,
        FirestoreConstants.aboutMe: aboutMe,
        FirestoreConstants.phoneNumber: phoneNumber,
      };

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoUrl = "";
    String nickname = "";
    String phoneNumber = "";

    try {
      aboutMe = doc.get(FirestoreConstants.aboutMe);
    } catch (e) {}
    try {
      aboutMe = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    try {
      aboutMe = doc.get(FirestoreConstants.nickname);
    } catch (e) {}
    try {
      aboutMe = doc.get(FirestoreConstants.phoneNumber);
    } catch (e) {}

    return UserChat(
      id: doc.id,
      photoUrl: photoUrl,
      nickname: nickname,
      aboutMe: aboutMe,
      phoneNumber: phoneNumber,
    );
  }
}
