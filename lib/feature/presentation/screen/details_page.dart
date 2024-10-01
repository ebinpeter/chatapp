import 'dart:io';
import 'package:chattick/config/firebase_setting/firebase.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:chattick/feature/presentation/widget/textfeild.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/colors.dart';
import '../../../core/media_query.dart';
import '../widget/elevated_button.dart';
import 'contact.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();

class _DetailsPageState extends State<DetailsPage> {
  File? _imageFile;
  bool isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImageToFirebase(File? imageFile) async {
    if (imageFile == null) return null;

    try {
      String fileName = path.basename(imageFile.path);
      Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print('Image uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }


  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Coloure().BackGround,
      statusBarIconBrightness: Brightness.dark,
    ));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloure().BackGround,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isPortrait = constraints.maxHeight > constraints.maxWidth;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  MediaQueryUtil.widthPercentage(context, isPortrait ? 4 : 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: isPortrait ? 50 : 40,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null, // Display selected image
                            child: _imageFile == null
                                ? Icon(
                              Icons.person,
                              size: isPortrait ? 50 : 40,
                              color: Colors.black54,
                            )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: isLoading
                                    ? const CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                                    : const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQueryUtil.heightPercentage(
                            context, isPortrait ? 5 : 3)),
                    CustomTextField(
                      labelText: "First Name",
                      controller: firstNameController,
                      isRequired: true,
                      height: MediaQueryUtil.heightPercentage(
                          context, isPortrait ? 8 : 16),
                      width: MediaQueryUtil.widthPercentage(
                          context, isPortrait ? 90 : 70),
                    ),
                    SizedBox(
                        height: MediaQueryUtil.heightPercentage(
                            context, isPortrait ? 3 : 2)),
                    CustomTextField(
                      labelText: "Last Name",
                      controller: lastNameController,
                      isRequired: false,
                      height: MediaQueryUtil.heightPercentage(
                          context, isPortrait ? 8 : 16),
                      width: MediaQueryUtil.widthPercentage(
                          context, isPortrait ? 90 : 70),
                    ),
                    SizedBox(
                      height: MediaQueryUtil.heightPercentage(
                          context, isPortrait ? 35 : 18),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child:CustomButton(
                          text: "Continue",
                          onPressed: () async {
                            String? imageUrl = await _uploadImageToFirebase(_imageFile);

                            if (imageUrl != null) {
                              await FirebaseApi().updateUserDetails(
                                firstNameController.text.trim(),
                                lastNameController.text.trim(),
                                imageUrl,
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ContactsList()),
                              );
                            } else {
                              print('Failed to upload image');
                            }
                          },
                        ),

                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
