import 'package:flutter/material.dart';
import 'package:programmes/widgets/image_gallery.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


class NewExerciseImage extends StatefulWidget {
  const NewExerciseImage({super.key});

  @override
  State<NewExerciseImage> createState() => _NewExerciseImageState();
}

class _NewExerciseImageState extends State<NewExerciseImage> {
  TextEditingController nameController = TextEditingController();
  String imagePath = 'exercise_images/null.jpg';
  List<String> imagePaths = [];
  final String assetDir = 'exercise_images';

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
        .where((String key) => key.startsWith(assetDir))
        .toList();

    setState(() => imagePaths = paths);
  }

  @override
@override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        TextField(
          controller: nameController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            constraints: BoxConstraints(maxWidth: width * 0.25),
            labelText: 'Nom',
            isDense: true,
            labelStyle: TextStyle(color: Colors.grey[400]),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          onEditingComplete: () {
            print('SUBMITTED');
            if (imagePath == 'exercise_images/null.jpg') {
              for (var i = 0; i < imagePaths.length; i++) {
                if (nameController.text.toLowerCase() == imagePaths[i].split('/').last.split('.').first.toLowerCase()) {
                  setState(() {
                    final newPath = nameController.text.split(' ').map((word) =>
                      word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : '')
                      .join(' ');
                    imagePath = 'exercise_images/$newPath.jpg';
                    nameController.text = newPath;
                  });
                }
              };
            }
          },
        ),

        ConstrainedBox(constraints: const BoxConstraints(minHeight: 8)),

        InkWell(
          onTap: () async {
            final newPath = await Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const ImageGallery()));

            if (newPath != null && mounted) {
              if (nameController.text.trim().isEmpty) {
                setState(() {
                  imagePath = newPath;
                  nameController.text = imagePath.split('/').last.split('.').first;
                });
              }
            }
          },

          child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          width: width * 0.25,
          height: width * 0.25,
          child: Icon(
            Icons.image_search, 
            color: Colors.white, 
            size: width * 0.1,
            ),
          ),
        ),
      ],
    );
  }
}