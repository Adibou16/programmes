import 'package:flutter/material.dart';
import 'package:programmes/widgets/image_gallery.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


class NewExerciseImage extends StatefulWidget {
  final String initialImagePath;
  final Function(String)? onImageSelected;
  const NewExerciseImage({super.key, required this.initialImagePath, this.onImageSelected});

  @override
  State<NewExerciseImage> createState() => _NewExerciseImageState();
}

class _NewExerciseImageState extends State<NewExerciseImage> {
  TextEditingController nameController = TextEditingController();
  late String imagePath;
  List<String> imagePaths = [];
  final String assetDir = 'exercise_images/default';

    @override
  void initState() {
    super.initState();

    imagePath = widget.initialImagePath;
    if (imagePath != 'exercise_images/other/null.jpg') {
      nameController.text = imagePath.split('/').last.split('.').first;
    }

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
            if (imagePath == 'exercise_images/other/null.jpg') {
              for (var i = 0; i < imagePaths.length; i++) {
                if (nameController.text.toLowerCase() == imagePaths[i].split('/').last.split('.').first.toLowerCase()) {
                  setState(() {
                    final newPath = nameController.text.split(' ').map((word) =>
                      word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : '')
                      .join(' ');
                    imagePath = 'exercise_images/default/$newPath.jpg';
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
                setState(() {
                  imagePath = newPath;
                  if (nameController.text.trim().isEmpty) {
                    nameController.text = imagePath.split('/').last.split('.').first;
                  }
                  widget.onImageSelected?.call(newPath);
                });
            }
          },

          child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
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