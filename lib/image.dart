import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
import '../../models/element.dart' as element;

import 'models/zone.dart';

class ImageZoningPage extends StatefulWidget {
  int idEtage;
  ImageZoningPage({super.key, required this.idEtage});

  @override
  _ImageZoningPageState createState() => _ImageZoningPageState();
}

class _ImageZoningPageState extends State<ImageZoningPage> {
  int idEtage = 0;
  File? _image;
  final List<Rect> _zones = [];
  Offset? _start;
  Offset? _end;
  int _selectedZoneIndex = -1;
  final List<Rect> _rects = [];

  List<Zone> _getZones() {
    List<Zone> zones = [
      Zone(x: 10, y: 10, width: 100, height: 50),
      Zone(x: 50, y: 80, width: 150, height: 100),
      Zone(x: 200, y: 150, width: 80, height: 60),
    ];

    return zones;
  }

  void _showMessage(int index) {
    // Afficher un message en fonction de l'index de la zone cliquée
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Zone ${index + 1}'),
        content: Text('Vous avez cliqué sur la zone ${index + 1}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // _getImage();
  }

  // Future<void> _getImage() async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'http://192.168.1.12:8080/public/uploads/wp2691434.jpg-1677613550295.jpeg'));
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         _image = File.fromRawPath(response.bodyBytes);
  //         _zones.clear();
  //         _zones.addAll(_getZones().map((zone) => Rect.fromLTWH(
  //             zone.x!.toDouble(),
  //             zone.y!.toDouble(),
  //             zone.width!.toDouble(),
  //             zone.height!.toDouble())));
  //       });
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _zones.clear();
        _zones.addAll(_getZones().map((zone) => Rect.fromLTWH(
            zone.x!.toDouble(),
            zone.y!.toDouble(),
            zone.width!.toDouble(),
            zone.height!.toDouble())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Zoning'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_image != null) ...[
              GestureDetector(
                  onTapUp: (details) {
                    // Parcourir toutes les zones et vérifier si le clic est à l'intérieur de l'une d'entre elles
                    for (int i = 0; i < _zones.length; i++) {
                      if (_zones[i].contains(details.localPosition)) {
                        _showMessage(i);
                        break;
                      }
                    }
                  },
                  child: Stack(
                    children: [
                      Image.file(_image!),
                      GestureDetector(
                        onPanStart: (details) {
                          _start = details.localPosition;
                          setState(() {
                            _selectedZoneIndex = -1;
                          });
                        },
                        onPanEnd: (details) {
                          if (_start != null && _end != null) {
                            final renderBox =
                                context.findRenderObject() as RenderBox;
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
                                      onPanStart: (details) {
                                        _start = details.localPosition;
                                        setState(() {
                                          _selectedZoneIndex = index;
                                        });
                                      },
                                      onPanEnd: (details) {
                                        _start = null;
                                        _end = null;
                                      },
                                      onPanUpdate: (details) {
                                        _end = details.localPosition;
                                        if (_start != null && _end != null) {
                                          final renderBox = context
                                              .findRenderObject() as RenderBox;
                                          final startLocal =
                                              renderBox.globalToLocal(_start!);
                                          final endLocal =
                                              renderBox.globalToLocal(_end!);
                                          setState(() {
                                            _rects[index] = Rect.fromPoints(
                                                startLocal, endLocal);
                                          });
                                        }
                                      },
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Zone $index'),
                                              content: Form(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Type',
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Nom',
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      onChanged: (value) {},
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Matiere',
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Hauteur',
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Largeur',
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {},
                                                      child: const Text(
                                                          'Soumettre'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color:
                                                Colors.yellow.withOpacity(0.8),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      ..._zones.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final Rect zone = entry.value;
                        return Positioned(
                          left: zone.left,
                          top: zone.top,
                          width: zone.width,
                          height: zone.height,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                            ),
                            child: Text('Zone ${index + 1}'),
                          ),
                        );
                      }).toList(),
                    ],
                  )),
            ],
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _getImage,
              icon: const Icon(Icons.image),
              label: const Text('Choisir une image'),
            ),
          ],
        ),
      ),
    );
  }
}
