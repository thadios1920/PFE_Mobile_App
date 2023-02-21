import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  List<Rect> _rects = [];
  int _selectedZoneIndex = -1;
  Offset? _start;
  Offset? _end;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Zones'),
      ),
      body: GestureDetector(
        onPanStart: (details) {
          _start = details.localPosition;
          setState(() {
            _selectedZoneIndex = -1;
          });
        },
        onPanEnd: (details) {
          _end = details.velocity.pixelsPerSecond;
          if (_start != null && _end != null) {
            final renderBox = context.findRenderObject() as RenderBox;
            final startLocal = renderBox.globalToLocal(_start!);
            final endLocal = renderBox.globalToLocal(_end!);
            setState(() {
              _rects.add(Rect.fromPoints(startLocal, endLocal));
              _start = null;
              _end = null;
            });
          }
        },
        onPanUpdate: (details) {
          _end = details.localPosition;
          setState(() {});
        },
        child: Stack(
          children: <Widget>[
            if (_image != null)
              Image.file(
                _image!,
                fit: BoxFit.cover,
              ),
            ..._rects.asMap().entries.map((entry) {
              final index = entry.key;
              final rect = entry.value;
              return Positioned.fromRect(
                rect: rect,
                child: Stack(
                  children: [
                    if (_selectedZoneIndex == index)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.8),
                            width: 2,
                          ),
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedZoneIndex = index;
                        });
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: _getImage,
                tooltip: 'Pick Image',
                child: Icon(Icons.add_a_photo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
