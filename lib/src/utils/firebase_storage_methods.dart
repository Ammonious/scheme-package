import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


Future<String> uploadImageRetrieveUrl({File image,String folderName, String imageName,Function onStart,Function(int percent) onProgress}) async {
	String fileName = '$folderName/$imageName.png';
	StorageReference storageRef = FirebaseStorage.instance.ref().child(fileName);
	if(onStart != null) onStart();

	StorageUploadTask uploadTask = storageRef.putFile(image);

	StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
	return await downloadUrl.ref.getDownloadURL();
}


Future<String> writeByteToImageFile(ByteData byteData) async {
	Directory dir = await getApplicationDocumentsDirectory();
	File imageFile = new File(
			"${dir.path}/flutter/${DateTime.now().millisecondsSinceEpoch}.png");
	imageFile.createSync(recursive: true);
	imageFile.writeAsBytesSync(byteData.buffer.asUint8List(0));
	return imageFile.path;
}

 Future<File> showImagePicker() async => ImagePicker.pickImage(source: ImageSource.gallery);

