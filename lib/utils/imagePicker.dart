import 'dart:io';
import 'package:image_picker/image_picker.dart';

 Future<File?> pickImage(ImageSource source)async{
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if(file != null){
    return File(file.path);
  }
  return null;
}
