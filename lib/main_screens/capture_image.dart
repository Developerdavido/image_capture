import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_capture/main_screens/home/home.dart';
import 'package:image_capture/main_screens/widgets/display_picture.dart';
import 'package:image_capture/main_screens/widgets/image_container.dart';
import 'package:image_capture/services/image_service.dart';


class CaptureImage extends StatefulWidget {
  final List<CameraDescription>? camera;
  const CaptureImage({Key? key, this.camera}) : super(key: key);

  @override
  State<CaptureImage> createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage>
    with WidgetsBindingObserver{
  CameraController? _controller;
  bool _isCameraInitialized = false;

  onNewCameraSelected(CameraDescription? cameraDescription) async{
    final previousCameraController = _controller;

    //instantiating the camera controller
    final CameraController cameraController = CameraController(
        cameraDescription!,
        ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg
    );

    //Dispose the previous controller
    await previousCameraController?.dispose();

    //replace with new controller
    if (mounted) {
      setState((){
        _controller = cameraController;
      });
    }

    //update UI if the controller is updated
    cameraController.addListener(() {
      if (mounted) {
        setState((){
        });
      }
    });

    //initialize controller
    try {
      await cameraController.initialize();
    }on CameraException catch (e) {
      print('Error in initializing camera: $e');
    }

    //Update the boolean
    if (mounted) {
      setState((){
        _isCameraInitialized = _controller!.value.isInitialized;
      });
    }

  }

  XFile? fileImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    onNewCameraSelected(widget.camera!.first);


  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    final CameraController? cameraController = _controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    }  else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text("Capture your Image"),
      ),
      body: _isCameraInitialized
        ? AspectRatio(
          aspectRatio: 1/_controller!.value.aspectRatio,
        child: CameraPreview(_controller!,
          child: Center (
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.greenAccent)
            ),
        ),
          )
      ),),
      ): Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final CameraController? cameraController = _controller;

            var  image = await cameraController!.takePicture();

            //crop the image
            var _croppedImage = await ImageService.cropImage(image);

            if(_croppedImage == null){
              return;
            }

            if (!mounted) return;

            await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DisplayPictureScreen(
                  imagePath: _croppedImage.path,
                ),
                ),
            );

          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
