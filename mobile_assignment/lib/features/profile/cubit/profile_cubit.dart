import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// Cubit
class ProfileCubit extends Cubit<ProfileState> {
  final ImagePicker _picker = ImagePicker();

  ProfileCubit() : super(ProfileInitial());

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? photo = await _picker.pickImage(source: source);
      if (photo != null) {
        emit(ProfileImageSelected(File(photo.path)));
      }
    } catch (e) {
      print("Image Picker Error: $e");
    }
  }
}

// State
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileImageSelected extends ProfileState {
  final File imageFile;

  ProfileImageSelected(this.imageFile);
}
