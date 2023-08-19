import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

part 'media_state.dart';

class MediaCubit extends Cubit<MediaState> {
  final ImagePicker _imagePicker;

  MediaCubit(this._imagePicker) : super(const MediaState());

  Future<List<int>> compressImage(Uint8List bytes) async {
    const maxImageLength = 1000000;

    final imageLength = bytes.length;
    if (imageLength < maxImageLength) return bytes;

    final img.Image image = img.decodeImage(bytes)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      compressQuality -= 10;

      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newByte.length;
    } while (length > maxImageLength);

    return newByte;
  }

  void setImage(String? imagePath, XFile? imageFile) {
    emit(MediaState(imagePath: imagePath, imageFile: imageFile));
  }

  void onGalleryView() async {
    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;

    if (isMacOS || isLinux) return;

    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      emit(MediaState(
        imagePath: pickedImage.path,
        imageFile: pickedImage,
      ));
    }
  }

  void onCameraView() async {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isIOS);

    if (isNotMobile) return;

    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      emit(MediaState(
        imagePath: pickedImage.path,
        imageFile: pickedImage,
      ));
    }
  }
}
