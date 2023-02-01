import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MediaPicker extends StatefulWidget {
  const MediaPicker({Key? key}) : super(key: key);

  @override
  _MediaPickerState createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  // Picked file
  late File _image;

  // Function to pick image from gallery or camera then crop it
  Future<File> pickImage(bool x) async {
    XFile? tempImage;
    if (x) {
      tempImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else {
      tempImage = await ImagePicker().pickImage(source: ImageSource.camera);
    }
    return (await ImageCropper.cropImage(
      sourcePath: tempImage!.path,
      maxWidth: 1080,
      maxHeight: 1080,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Cropper',
        showCropGrid: false,
        toolbarColor: Colors.blue,
        activeControlsWidgetColor: Colors.blue,
        statusBarColor: Colors.white,
        toolbarWidgetColor: Colors.white,
      ),
    ))!;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      titlePadding: EdgeInsets.all(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.blue.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Container(
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blueGrey),
        child: Text(
          'Upload From:',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      content: SizedBox(
        width: 100,
        height: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton(
                    onPressed: () async {
                      _image = await pickImage(true);
                      Navigator.pop(context, _image);
                    },
                    iconSize: 75,
                    splashColor: Colors.white,
                    icon: Icon(
                      Icons.folder,
                      color: Colors.blueGrey,
                    )),
                Text('Gallery')
              ],
            ),
            Column(
              children: [
                IconButton(
                    onPressed: () async {
                      _image = await pickImage(false);
                      Navigator.pop(context, _image);
                    },
                    iconSize: 75,
                    splashColor: Colors.white,
                    icon: Icon(
                      Icons.camera,
                      color: Colors.blueGrey,
                    )),
                Text('Camera')
              ],
            )
          ],
        ),
      ),
    );
  }
}
