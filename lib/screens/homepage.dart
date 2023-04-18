import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter_camera_demo/screens/takepicture.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _path;

  void _showPhotoLibrary() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _path = file?.path;
    });
  }

  void _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TakePicturePage(camera: camera)),
    );
    setState(() {
      _path = result;
    });
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 150,
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  _showCamera();
                },
                leading: const Icon(Icons.photo_camera),
                title: const Text("Take a picture from camera"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  _showPhotoLibrary();
                },
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from photo library"),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text("Click to add Pictures"),
              onPressed: () {
                _showOptions(context);
              },
            ),
            _path != null
                ? Image.file(File(_path!))
                : SizedBox.shrink(), // Show the image if it exists, otherwise hide
          ],
        ),
      ),
    );
  }
}