

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageService {

  static Future<CroppedFile?> cropImage(XFile? imageFile) async {
    var croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile!.path,
      cropStyle: CropStyle.circle,
      aspectRatioPresets: Platform.isAndroid
        ? [
          CropAspectRatioPreset.square,
      ] : [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.white,
          toolbarWidgetColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        )
      ]
    );
    return croppedFile;
  }

}