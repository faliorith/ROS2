import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageUtils {
  static const List<Map<String, dynamic>> _iconSizes = [
    {'platform': 'android', 'path': 'android/app/src/main/res/mipmap-mdpi/ic_launcher.png', 'size': 48},
    {'platform': 'android', 'path': 'android/app/src/main/res/mipmap-hdpi/ic_launcher.png', 'size': 72},
    {'platform': 'android', 'path': 'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png', 'size': 96},
    {'platform': 'android', 'path': 'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png', 'size': 144},
    {'platform': 'android', 'path': 'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png', 'size': 192},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png', 'size': 20},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png', 'size': 40},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png', 'size': 60},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png', 'size': 29},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png', 'size': 58},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png', 'size': 87},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png', 'size': 40},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png', 'size': 80},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png', 'size': 120},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png', 'size': 120},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png', 'size': 180},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png', 'size': 76},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png', 'size': 152},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png', 'size': 167},
    {'platform': 'ios', 'path': 'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png', 'size': 1024},
  ];

  static Future<void> prepareAppIcons() async {
    final File originalIcon = File('assets/icons/original_icon.png');
    if (!await originalIcon.exists()) {
      throw Exception('Исходный файл иконки не найден');
    }

    final Uint8List imageBytes = await originalIcon.readAsBytes();
    final img.Image? originalImage = img.decodeImage(imageBytes);

    if (originalImage == null) {
      throw Exception('Не удалось декодировать изображение');
    }

    for (final iconConfig in _iconSizes) {
      final String path = iconConfig['path'];
      final int size = iconConfig['size'];

      final img.Image resizedImage = img.copyResize(
        originalImage,
        width: size,
        height: size,
        interpolation: img.Interpolation.average,
      );

      final File outputFile = File(path);
      await outputFile.parent.create(recursive: true);
      await outputFile.writeAsBytes(img.encodePng(resizedImage));
    }
  }
} 