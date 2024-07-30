import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

Future<String?> getImageFromGallery() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );
  if (result != null) {
    return result.files.single.path;
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
