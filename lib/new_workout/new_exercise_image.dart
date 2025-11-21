import 'package:flutter/material.dart';
import 'package:programmes/widgets/image_gallery.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';


class NewExerciseImage extends StatefulWidget {
  final String initalExerciseName;
  final String initialImagePath;
  final Function(String)? onNameChanged;
  final Function(String)? onImageSelected;
  const NewExerciseImage({super.key, required this.initalExerciseName,required this.initialImagePath, this.onNameChanged, this.onImageSelected});

  @override
  State<NewExerciseImage> createState() => _NewExerciseImageState();
}

class _NewExerciseImageState extends State<NewExerciseImage> {
  TextEditingController nameController = TextEditingController();
  late String exerciseName;
  late String imagePath;
  List<String> imagePaths = [];
  final String assetDir = 'exercise_images/default';

  ImageProvider getImageProvider(String path) {
    if (path.startsWith('exercise_images') | path.startsWith('other')) {
      return AssetImage(path);
    }
    return FileImage(File(path));
  }

  @override
  void initState() {
    super.initState();
    exerciseName = widget.initalExerciseName;
    nameController.text = exerciseName;
    imagePath = widget.initialImagePath;

    _loadAssets();
  }

  Future<void> _loadAssets() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final paths = manifestMap.keys
        .where((String key) => key.startsWith(assetDir))
        .toList();

    setState(() => imagePaths = paths);
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        TextField(
          controller: nameController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            constraints: BoxConstraints(maxWidth: width * 0.35),
            labelText: 'Nom',
            isDense: true,
            labelStyle: TextStyle(color: Colors.grey[400], fontSize: width * 0.045),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),

          onEditingComplete: () {
            if (nameController.text.isNotEmpty) {
                setState(() {
                  exerciseName = nameController.text;
                  widget.onNameChanged?.call(exerciseName);
              });
            }

            if (imagePath == 'exercise_images/other/null.jpg') {
              for (var i = 0; i < imagePaths.length; i++) {
                if (nameController.text.toLowerCase() == imagePaths[i].split('/').last.split('.').first.toLowerCase()) {
                  setState(() {
                    final newPath = nameController.text.split(' ').map((word) =>
                      word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : '')
                      .join(' ');
                    imagePath = 'exercise_images/default/$newPath.jpg';
                    nameController.text = newPath;
                    widget.onImageSelected?.call(newPath);
                  });
                }
              }
            }
          },
        ),

        ConstrainedBox(constraints: const BoxConstraints(minHeight: 8)),

        InkWell(
          onTap: () async {
            final newPath = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ImageGallery()));

            if (newPath != null && mounted) {
                setState(() {
                  imagePath = newPath;
                  if (nameController.text.trim().isEmpty) {
                    nameController.text = imagePath.split('/').last.split('.').first;
                    exerciseName = nameController.text;
                    widget.onNameChanged?.call(exerciseName);
                  }
                  widget.onImageSelected?.call(newPath);
                });
            }
          },

          child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: getImageProvider(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          width: width * 0.3,
          height: width * 0.3,
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