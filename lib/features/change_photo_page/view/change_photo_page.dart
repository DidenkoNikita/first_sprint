import 'dart:io';

import 'package:evently_sprint/features/change_photo_page/widgets/widgets.dart';
import 'package:evently_sprint/requests/upload_avatar/request.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangePhotoPage extends StatefulWidget {
  const ChangePhotoPage({super.key, required this.user});
  final dynamic user;

  @override
  State<ChangePhotoPage> createState() => _ChangePhotoPageState();
}

class _ChangePhotoPageState extends State<ChangePhotoPage> {
  @override
  Widget build(BuildContext context) {
    final storage = FirebaseStorage.instanceFor(
        bucket: 'gs://evently-app-4eda5.appspot.com/avatars');
    return Scaffold(
      appBar: const ChangePhotoHeader(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/png/background_comments.png'),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 365,
              height: 695,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(24, 24, 24, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: Text(
                widget.user['user']['name'].substring(0, 1),
                style: const TextStyle(
                  fontSize: 128,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )),
            ),
            const SizedBox(
              height: 26,
            ),
            Container(
              width: 365,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(227, 245, 99, 1),
              ),
              child: TextButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    Reference ref = storage.ref().child(
                        'avatars/image.jpg');
                    UploadTask uploadTask = ref.putFile(File(image.path));

                    uploadTask.whenComplete(() async {
                      String url = await ref.getDownloadURL();
                      print("Download URL: $url");
                      final avatar = await UploadAvatar(image: url).uploadAvatar();
                      setState(() {
                        widget.user['user']['link_avatar'] = avatar;
                      });
                    });
                  }
                },
                child: Text(
                  widget.user['user']['link_avatar'] == null
                      ? 'Add photo'
                      : 'Change photo',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
