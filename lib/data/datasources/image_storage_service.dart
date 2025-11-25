import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

@injectable
class ImageStorageService {
  Future<String> saveImage(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagesDir = Directory('${directory.path}/attendance_images');

    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}${path.extension(imageFile.path)}';
    final savedImage = File('${imagesDir.path}/$fileName');

    await imageFile.copy(savedImage.path);
    return savedImage.path;
  }

  Future<void> deleteImage(String imagePath) async {
    final file = File(imagePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
