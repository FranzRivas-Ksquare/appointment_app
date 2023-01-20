import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<Uint8List> uploadImageCamera({required String source}) async {
    var file = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
    if (file != null) {
      Uint8List fileAs8 = await file.readAsBytes();
      return fileAs8;
    }
    return Uint8List(0);
  }

  Future<Uint8List> uploadImageGallery({required String source}) async {
    var file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    if (file != null) {
      Uint8List fileAs8 = await file.readAsBytes();
      return fileAs8;
    }
    return Uint8List(0);
  }
}
