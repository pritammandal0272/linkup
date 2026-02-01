import 'package:image_picker/image_picker.dart';

class GlobalImagepicker {
  static final ImagePicker _imagePicker = ImagePicker();
  static Future cameraImage() async {
    XFile? cameraImage = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (cameraImage == null) {
      return null;
    }
    return cameraImage;
  }

  static Future galleryImage() async {
    XFile? galleryImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (galleryImage == null) {
      return null;
    }
    return galleryImage;
  }
}
