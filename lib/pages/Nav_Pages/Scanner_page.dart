import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  XFile? _image;

  Future<void> _pickImage() async {
    try {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = image;
      });
    } else {
      // Handle the case where the user cancels the image picker
      print("No image selected.");
    }
    } catch (e) {
      // Handle any exceptions that might occur
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image != null
                  ? (
                    Column(
                      children: [
                        Image.file(File(_image!.path)),

                        const SizedBox(height: 20),
                        // to take another image
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: _pickImage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                child: const Icon(
                                  Icons.camera_alt, 
                                  size: 30, 
                                  color: Colors.white),
                              ),
                              
                              // to comfirm the image
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Icon(
                                  Icons.check, 
                                  size: 30, 
                                  color: Colors.white),
                              ),
                            ],
                          ),
                        )

                      ],
                    )
                    )
                  : (
                    Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          icon: const Icon(
                            Icons.camera_alt, 
                            color: Colors.white,
                            
                          ),
                          label: const Text(
                            'Capture Image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                    ),
             
            ],
          ),
        ),
      ),
    );
  }

}
