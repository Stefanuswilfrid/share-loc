import 'dart:typed_data'; // Import for web platform
import 'dart:io' as io; // Import for mobile platform
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

final storageRef = FirebaseStorage.instance.ref();

class UploadStorage {
  // Adjusted method to accept Uint8List directly for web or file path for mobile
  static Future<String?> uploadFile(
      {required String filePath, Uint8List? fileBytes}) async {
    print("Upload called?");

    // Generate unique ID for the file
    var uuid = const Uuid();
    final String picId = uuid.v4();
    print("picId $picId");

    try {
      if (kIsWeb) {
        // Web platform
        if (fileBytes == null) {
          print("File bytes are null, fetching from URL");
          final bytes = await _fetchFileBytes(filePath);
          if (bytes == null) return null;

          final snapshot =
              await storageRef.child('pinPics/$picId').putData(bytes);
          final downloadURL = await snapshot.ref.getDownloadURL();
          print("snapshot $downloadURL");
          return downloadURL;
        } else {
          final snapshot =
              await storageRef.child('pinPics/$picId').putData(fileBytes);
          final downloadURL = await snapshot.ref.getDownloadURL();
          print("snapshot $downloadURL");
          return downloadURL;
        }
      } else {
        // Mobile platform
        final io.File file = io.File(filePath);
        final snapshot = await storageRef.child('pinPics/$picId').putFile(file);
        final downloadURL = await snapshot.ref.getDownloadURL();
        print("snapshot $downloadURL");
        return downloadURL;
      }
    } catch (e) {
      print("Error uploading file: $e");
      return null;
    }
  }

  // Fetch file bytes from a URL
  static Future<Uint8List?> _fetchFileBytes(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print("Failed to load file from URL");
        return null;
      }
    } catch (e) {
      print("Error fetching file bytes: $e");
      return null;
    }
  }
}
