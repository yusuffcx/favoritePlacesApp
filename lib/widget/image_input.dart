import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  var img;
  void _takePicture() async {
    final takenImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 600);
    setState(() {
      if (takenImage != null) {
        img = File(takenImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body = img != null
        ? GestureDetector(
            onTap: _takePicture,
            child: Image.file(img, fit: BoxFit.cover),
          )
        : ElevatedButton.icon(
            onPressed: _takePicture,
            label: const Text('Take Picture'),
            icon: const Icon(Icons.camera));

    return Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 250,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color:
                    Theme.of(context).colorScheme.onPrimary.withOpacity(0.2))),
        child: body);
  }
}
