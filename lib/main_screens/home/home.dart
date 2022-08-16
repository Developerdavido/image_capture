import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_capture/main_screens/capture_image.dart';
import 'package:image_capture/main_screens/widgets/image_container.dart';

class Home extends StatefulWidget {
  final String imagePath;
  const Home({Key? key,required this.imagePath}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Capture your Image"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: height * 0.1,),
            ImageContainer(
              imageData: widget.imagePath,
              onPressed: ( )async {
                Navigator.pop(context);
                await availableCameras().then((value) =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CaptureImage(camera: value,)))
                );
              },
            )
          ],
        ),
      ),
    );
  }

}
