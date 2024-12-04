import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  void _takePicture() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      height: 250,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2))),
      child: ElevatedButton.icon(
          onPressed: _takePicture,
          label: const Text('Take Picture'),
          icon: const Icon(Icons.camera)),
    );
  }
}
