import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<String> uploadImageCamera({required String source}) async {
    var file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      print(file.path.toString());
      return file.path.toString();
    }
    return "";
  }

  Future<String> uploadImageGallery({required String source}) async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      print(file.path.toString());
      return file.path.toString();
    }
    return "";
  }
}
