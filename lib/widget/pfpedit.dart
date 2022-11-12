import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectb2b/endpoints.dart';
import 'package:projectb2b/http.dart' as http_test;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final ImagePicker _picker = ImagePicker();
  late SharedPreferences prefs;
  String? pfp;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    initpreference();
  }

  Future<void> initpreference() async {
    prefs = await SharedPreferences.getInstance();
    pfp = prefs.getString('pfp');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(
            pfp ?? 'https://img.icons8.com/windows/344/guest-male--v1.png'
          ),
          radius: 35,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: const Color.fromARGB(255, 224, 232, 235)
              )
            ),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    backgroundColor:const Color.fromARGB(255, 224, 232, 235),
                    title: const Center(
                      child: Text('Pick Image From')
                    ),
                    titleTextStyle: const TextStyle(
                      color: Color.fromARGB(255, 23, 22, 29),
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600
                    ),
                    content: SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  primary: const Color.fromARGB(255, 23, 22, 29),
                                  onPrimary: const Color.fromARGB(255, 224, 232, 235)
                                ),
                                onPressed: () async{
                                  XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
                                  if (pickedImage != null) {
                                    if (mounted) {
                                      Navigator.pop(context);
                                    }
                                    Uint8List imageBytes = await pickedImage.readAsBytes();
                                    String result = base64.encode(imageBytes);
                                    // print(result);

                                    var response = await http_test.put(
                                      url: urlChangePicture, 
                                      body: {
                                        "base64": result
                                      }
                                    );

                                    if (response.isSuccess) {
                                      setState(() {
                                        var avatar = response.data['avatar'];
                                        prefs.setString('pfp', avatar);
                                        pfp = prefs.getString('pfp');
                                      });
                                      // print('sugsegs');
                                      // print(response.data);
                                    }
                                  }
                                }, 
                                child: const SizedBox(
                                  height: 75,
                                  child: Icon(Icons.photo_camera_outlined),
                                )
                              ),
                              const Text(
                                'Camera',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color.fromARGB(255, 23, 22, 29),
                                  fontSize: 14, 
                                  fontWeight: FontWeight.w600
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  primary: const Color.fromARGB(255, 23, 22, 29),
                                  onPrimary: const Color.fromARGB(255, 224, 232, 235)
                                ),
                                onPressed: () async{
                                  XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
                                  if (pickedImage != null) {
                                    if (mounted) {
                                      Navigator.pop(context);
                                    }
                                    Uint8List imageBytes = await pickedImage.readAsBytes();
                                    String result = base64.encode(imageBytes);
                                    
                                    // print(result);
                                    var response = await http_test.put(
                                      url: urlChangePicture, 
                                      body: {
                                        "base64": result
                                      }
                                    );

                                    if (response.isSuccess) {
                                      setState(() {
                                        var avatar = response.data['avatar'];
                                        prefs.setString('pfp', avatar);
                                        pfp = prefs.getString('pfp');
                                      });
                                    }
                                  }
                                }, 
                                child: const SizedBox(
                                  height: 75,
                                  child: Icon(Icons.collections_outlined),
                                )
                              ),
                              const Text(
                                'Gallery', 
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color.fromARGB(255, 23, 22, 29),
                                  fontSize: 14, 
                                  fontWeight: FontWeight.w600
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),                                  
                  )
                );
              },
              padding: const EdgeInsets.all(0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.edit_outlined, 
                size: 15,
                color: Color.fromARGB(255, 26, 25, 32)
              ),
            ),
          ),
        )
      ],
    );
  }
}