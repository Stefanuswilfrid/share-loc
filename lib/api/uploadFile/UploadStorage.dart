import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

final storageRef = FirebaseStorage.instance.ref();

class UploadStorage {
  static Future<String?> uploadFile({required String filePath}) async {
    File file = File(filePath);

    var uuid = const Uuid();
    final String picId = uuid.v4();

    var snapshot = await storageRef.child('pinPics/$picId').putFile(file);
    return snapshot.ref.getDownloadURL();
  }
}
