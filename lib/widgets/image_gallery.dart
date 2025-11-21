import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List<String> imagePaths = [];
  final String defaultDir = 'exercise_images/default';
  final String userDir = 'exercise_images/user';

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
        .where((String key) => key.startsWith(defaultDir))
        .toList();

    setState(() => imagePaths = paths);
  }

  Future<String?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile == null) return null;

    final Directory appDir = await getApplicationDocumentsDirectory();

    final Directory assetDir = Directory('${appDir.path}/exercise_images/user');
    if (!await assetDir.exists()) {
      await assetDir.create(recursive: true);
    }
    
    final String fileName = 'img_${DateTime.now().millisecondsSinceEpoch}${p.extension(pickedFile.path)}';
    final String savedPath = p.join(assetDir.path, fileName);
    final File savedImage = await File(pickedFile.path).copy(savedPath);
    return savedImage.path;
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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: TextButton(
              onPressed: () async {
                final userImage = await pickImageFromGallery();
                Navigator.pop(context, userImage);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ), 
              child: const Text(
                "Choisir à partir de l'appareil",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          const Text(
            "Images par défault",
            style: TextStyle(
              color: Colors.white, 
              fontSize: 20, 
              decoration: TextDecoration.underline,
              decorationColor: Colors.white 
            ),
          ),

          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
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
              },
            ),
          ),
        ],
      ),
    );
  }
}