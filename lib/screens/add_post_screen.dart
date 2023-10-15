// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController desctiption = TextEditingController();
  bool isLoaing = false;
  Uint8List? file;

  void postImage(String uid, String username, String image) async {
    setState(() => isLoaing = true);

    try {
      String res = await FirestoreMethods()
          .uploadPost(desctiption.text, file!, uid, username, image);

      if (res == "success") {
        showSnackBar(context, 'Posted!');
        clearImage();
      } else {
        showSnackBar(context, res);
      }

      setState(() => isLoaing = false);
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  Future selectImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Create a post'),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Take a photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() => this.file = file);
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Choose from galery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() => this.file = file);
              },
            ),
            SimpleDialogOption(
              onPressed: () async => Navigator.of(context).pop(),
              padding: EdgeInsets.all(20),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() => file = null);
  }

  @override
  void dispose() {
    desctiption.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return file == null
        ? Center(
            child: IconButton(
              onPressed: () => selectImage(context),
              icon: Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.mobileBackground,
              leading: IconButton(
                onPressed: clearImage,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
              title: Text('Post to'),
              actions: [
                TextButton(
                  onPressed: () {
                    postImage(user.uid, user.username, user.photoUrl);
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: AppColor.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                isLoaing
                    ? const LinearProgressIndicator()
                    : Padding(padding: EdgeInsets.only(top: 0)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(user.photoUrl)),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .3,
                      child: TextField(
                        maxLines: 8,
                        controller: desctiption,
                        decoration: InputDecoration(
                          hintText: 'Write a caption...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColor.secondary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              alignment: FractionalOffset.topCenter,
                              image: MemoryImage(file!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
