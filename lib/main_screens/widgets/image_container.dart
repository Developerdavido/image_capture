import 'package:flutter/material.dart';


class ImageContainer extends StatelessWidget {
  final String imageData;
  final VoidCallback onPressed;
  const ImageContainer({Key? key, required this.imageData, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: width * 0.5,
          width: width * 0.5,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.purple
          ),
        ),
        Positioned(
          bottom: 5,
            right: 24,
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 0.2)
                ),
                child: const Icon(Icons.camera_alt_outlined,
                  size: 48,
                  color: Colors.purple,
                ),
              ),
            ),
        )
      ],
    );
  }
}
