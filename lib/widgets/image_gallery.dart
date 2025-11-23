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
  List<String> defaultImagePaths = [];
  List<String> userImagePaths = [];
  final String defaultDir = 'exercise_images/default';
  final String userDir = 'exercise_images/user';

  Future<String?> askForImageName(BuildContext context) async {
    TextEditingController controller = TextEditingController();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text("Nom de l'exercice", style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Entrer le nom de l'exercice...", hintStyle: TextStyle(color: Colors.grey[700]),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[700]!),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text("Annuler", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text.trim());
              },
              child: const Text("Sauvegarder", style: TextStyle(color: Colors.blue),),
            ),
          ],
        );
      },
    );
  }
  

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final paths = manifestMap.keys
        .where((String key) => key.startsWith(defaultDir))
        .toList();

    setState(() {
      defaultImagePaths = paths;
    });

    await _loadUserImages();
  }

  Future<void> _loadUserImages() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final Directory userImageDir = Directory('${appDir.path}/$userDir');

    if (!await userImageDir.exists()) {
      await userImageDir.create(recursive: true);
    }

    final files = userImageDir
        .listSync()
        .where((f) => f.path.endsWith('.png') || f.path.endsWith('.jpg') || f.path.endsWith('.jpeg'))
        .map((f) => f.path)
        .toList();

    setState(() {
      userImagePaths = files;
    });
  }

  Future<void> deleteUserImage(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
    await _loadUserImages();
  }

  Future<String?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile == null) return null;

    final String? imageName = await askForImageName(context);
    if (imageName == null || imageName.isEmpty) return null;

    final Directory appDir = await getApplicationDocumentsDirectory();
    final Directory assetDir = Directory('${appDir.path}/exercise_images/user');
    if (!await assetDir.exists()) {
      await assetDir.create(recursive: true);
    }

    if (!await assetDir.exists()) {
      await assetDir.create(recursive: true);
    }
    
    final String extension = p.extension(pickedFile.path);
    final String fileName = '${imageName.trim()}$extension';

    final String savedPath = p.join(assetDir.path, fileName);
    final File savedImage = await File(pickedFile.path).copy(savedPath);
    return savedImage.path;
  }

  @override
  Widget build(BuildContext context) {
    if (defaultImagePaths.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar( // App Bar
        title: const Text("Sélectionner l'image"),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: TextButton(
                onPressed: () async {
                  final userImage = await pickImageFromGallery();
                  await _loadUserImages();
                  Navigator.pop(context, userImage);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ), 
                child: const Text(
                  "Sélectionner à partir de l'appareil",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            userImagePaths.isNotEmpty ? const Text(
              "Vos images",
              style: TextStyle(
                color: Colors.white, 
                fontSize: 20, 
                decoration: TextDecoration.underline,
                decorationColor: Colors.white 
              ),
            ) : const SizedBox.shrink(),

            // User images
            userImagePaths.isNotEmpty ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: userImagePaths.length,
              itemBuilder: (context, index) {
                final path = userImagePaths[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, path);
                  },
                  onLongPress: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: Colors.grey[900],
                        title: const Text("Supprimer l'image", style: TextStyle(color: Colors.white70)),
                        content: const Text("L'image sera supprimer de TOUS les programmes d'entrainements.", style: TextStyle(color: Colors.white70)),
                        actions: [
                          TextButton(
                            child: const Text("Annuler", style: TextStyle(color: Colors.white70)),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          TextButton(
                            child: const Text("Supprimer", style: TextStyle(color: Colors.red)),
                            onPressed: () => setState(() {
                              Navigator.pop(context, true);
                            })
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await deleteUserImage(path);
                    }
                  },
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      child: Image.file(
                        File(path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ) : const SizedBox.shrink(),
          
            const Text(
              "Images par défault",
              style: TextStyle(
                color: Colors.white, 
                fontSize: 20, 
                decoration: TextDecoration.underline,
                decorationColor: Colors.white 
              ),
            ),
        
            // Asset images
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: defaultImagePaths.length,
              itemBuilder: (context, index) {
                return IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: double.infinity,
                  icon: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      child: Image.asset(
                        defaultImagePaths[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, defaultImagePaths[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}