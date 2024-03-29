import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    //in which location we want to save the image
    //like profilePic/uid/
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      //means we are creating an unique post id under ref directory
      ref = ref.child(id);
    }

    //Ready the file want to upload
    UploadTask uploadTask = ref.putData(file); //using putData for Uint8List

    //completing upload task
    TaskSnapshot snap = await uploadTask;

    //Getting picture url for further use
    await ref.putData(file);
    //
    String downloadUrl = await snap.ref.getDownloadURL();

    print('File Uploaded: $downloadUrl');
    return downloadUrl;
  }
}
