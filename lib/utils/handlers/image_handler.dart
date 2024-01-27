// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageHandler {
//   static Future<XFile?> pickAndCropImage() async {
//     final imagePicker = ImagePicker();

//     try {
//       final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

//       if (pickedFile != null) {
//         XFile? croppedFile = await ImageCropper().cropImage(sourcePath: pickedFile.path, aspectRatioPresets: [
//           CropAspectRatioPreset.square,
//           CropAspectRatioPreset.ratio3x2,
//           CropAspectRatioPreset.original,
//           CropAspectRatioPreset.ratio4x3,
//           CropAspectRatioPreset.ratio16x9,
//         ], uiSettings: [
//           AndroidUiSettings(
//             toolbarTitle: 'Crop Image',
//             toolbarColor: Colors.deepOrange,
//             toolbarWidgetColor: Colors.white,
//             initAspectRatio: CropAspectRatioPreset.original,
//             lockAspectRatio: false,
//           ),
//           IOSUiSettings(
//             title: 'Crop Image',
//           ),
//         ]);

//         return croppedFile;
//       } else {
//         // User canceled the image selection.
//         return null;
//       }
//     } catch (e) {
//       log("Error picking/cropping image: $e");
//       return null;
//     }
//   }
// }
