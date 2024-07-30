import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<String?> getImageFromGallery() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    return image.path;
  }
  return null;
}

Future<String?> getImageFromCamera() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.camera);

  if (image != null) {
    return image.path;
  }
  return null;
}
