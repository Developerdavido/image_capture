import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width =  MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Display the picture'),),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(width * 0.5)),
            child: Image.file(File(imagePath))),
      ),
    );
  }
}
