import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';

class Storage {
  static Future<String> uploadProfileImage(
      {@required String uid, @required File profileImageFile}) async {
    try {
      String fileName = 'profileImages/$uid/image';
      firebase_storage.Reference reference =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      await reference.putFile(profileImageFile);
      String profileIageURL = await reference.getDownloadURL();
      return profileIageURL;
    } catch (e) {
      return null;
    }
  }
}
