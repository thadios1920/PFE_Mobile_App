import 'dart:io';
import 'package:flutter/material.dart';

class EtageDetails extends StatefulWidget {
  File imageFile = File("");

  EtageDetails({
    super.key,
  });
  @override
  State<EtageDetails> createState() => _EtageDetailsState();
}

class _EtageDetailsState extends State<EtageDetails> {
  final List<Rect> _rects = [];

  void _addRect(Offset start, Offset end) {
    final rect = Rect.fromPoints(start, end);
    setState(() {
      _rects.add(rect);
    });
  }

  void _showForm(BuildContext context, Rect rect) {
    showDialog(
      context: context,
      builder: (context) {
        return Positioned(
          left: rect.left,
          top: rect.top,
          child: SizedBox(
            width: rect.width,
            height: rect.height,
            child: const Form(
              // le contenu de votre formulaire ici
              child: Placeholder(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanDown: (details) {
          setState(() {
            final renderBox = context.findRenderObject() as RenderBox;
            final localPosition =
                renderBox.globalToLocal(details.globalPosition);
            _addRect(localPosition, localPosition);
          });
        },
        onPanUpdate: (details) {
          setState(() {
            final renderBox = context.findRenderObject() as RenderBox;
            final localPosition =
                renderBox.globalToLocal(details.globalPosition);
            final rect = _rects.last.shift(localPosition - _rects.last.center);
            _addRect(rect.topLeft, rect.bottomRight);
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network("widget.imageFile"),
            ),
            ..._rects.map((rect) {
              return Positioned.fromRect(
                rect: rect,
                child: GestureDetector(
                  onTap: () => _showForm(context, rect),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

uploadImage(File image) {}
