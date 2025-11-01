import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ImageGallery extends StatefulWidget {
  final String assetDir;
  const ImageGallery({super.key, this.assetDir = 'exercise_images'});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List<String> imagePaths = [];

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);


    // Extract all image file paths that start with the given directory
    final paths = manifestMap.keys
        .where((String key) => key.startsWith(widget.assetDir))
        .toList();

    setState(() => imagePaths = paths);
  }

  @override
  Widget build(BuildContext context) {
    if (imagePaths.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar( // App Bar
        title: const Text("Choisir Image"),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          if (imagePaths[index] != 'exercise_images/null.jpg') {
            return IconButton(
              padding: EdgeInsets.zero,
              iconSize: double.infinity,
              icon: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context, imagePaths[index]);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}