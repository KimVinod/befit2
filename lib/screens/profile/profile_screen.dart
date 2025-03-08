import 'dart:io';
import 'package:befit_v2/screens/home/home_screen.dart';
import 'package:befit_v2/screens/onboard/onboard_screen.dart';
import 'package:befit_v2/utils/constants.dart';
import 'package:befit_v2/utils/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late Box userDataBox, userFitnessDataBox;
  String userName = '', userPic = '';

  loadData() async {
    userDataBox = await Hive.openBox("userDataBox");

    setState(() {
      userName = userDataBox.get("name", defaultValue: "");
      userPic = userDataBox.get("profilePic", defaultValue: "");
    });
  }

  Future clearFitnessData() async {
    userFitnessDataBox = await Hive.openBox("userFitnessDataBox");
    await userFitnessDataBox.clear();
  }

  showResetDialogBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text("Do you want to reset?"),
            content: const Text("This will reset your calories and water intake. You can't revert back later!", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),),
            actions: [
              TextButton(onPressed: ()=> Navigator.pop(context), child: const Text("NO")),
              TextButton(
                onPressed: () {
                  clearFitnessData().then((value) => {
                    if(context.mounted) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Home()), (route) => false)
                  });
                },
                child: const Text("YES"),
              ),
            ],
          );
        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  File? _image;
  final imagePick = ImagePicker();


  Future<File?> captureAndSaveImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (pickedImage == null) {
      if(!mounted) return null;
      UIComponents.showSnackBar(context, "No image selected!", const Duration(seconds: 3));
      return null;
    }

    try {
      final directory = await getExternalStorageDirectory();
      if (directory != null) return File(pickedImage.path).copy('${directory.path}/${path.basename(pickedImage.path)}');
    } catch (e) {
      return null;
    }
    return null;
  }


  setProfilePic() {
    showDialog(context: context, builder: (context) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: const Text("Choose existing photo", style: TextStyle(fontSize: 16),),minVerticalPadding: 0,dense: true,
              onTap: () async {
                Navigator.pop(context);
                File? file = await captureAndSaveImage(ImageSource.gallery);
                if(file!=null) {
                  userDataBox.put("profilePic", file.path).then((value) {
                    setState(() {
                      userPic = file.path;
                    });
                  });
                }
              },
            ),
            ListTile(title: const Text("Take photo", style: TextStyle(fontSize: 16)),minVerticalPadding: 0,dense: true,
              onTap: () async {
                Navigator.pop(context);
                File? file = await captureAndSaveImage(ImageSource.gallery);
                if(file!=null) {
                  userDataBox.put("profilePic", file.path).then((value) {
                    setState(() {
                      userPic = file.path;
                    });
                  });
                }
              },
            ),
          ],
        ),
      );
    });
  }

  Future imagePickerGallery() async {
    final pick = await  imagePick.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pick != null) {
        _image = File(pick.path);
        //print("VINOD: ${pick.path}");
      } else {
        UIComponents.showSnackBar(context, "No file selected", const Duration(seconds: 2));
      }
    });
  }

  Future imagePickerCamera() async {
    final pick = await  imagePick.pickImage(source: ImageSource.camera);
    setState(() {
      if(pick != null) {
        _image = File(pick.path);
        //print("VINOD: ${pick.path}");
      } else {
        UIComponents.showSnackBar(context, "No file selected", const Duration(seconds: 2));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: appUIPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 22,),
                        onTap: ()=> Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Text("Profile", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Material(
                        color: Colors.white60,
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: () => setProfilePic(),
                          splashColor: Colors.black26,
                          customBorder: const CircleBorder(),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle
                            ),
                            child:
                            /*CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: FileImage(File("")),
                              onBackgroundImageError: (_,__) => Container(color: Colors.transparent),
                            )*/
                            ClipOval(
                              child: userPic==""
                                  ? const Center(child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Click to add your profile pic", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54,fontSize: 11),),
                              ))
                                  : Image.file(
                                File(userPic),
                                fit: BoxFit.cover,
                                errorBuilder: (context, _, __) => const Center(child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Error occurred", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54,fontSize: 12),),
                                )),
                              ),
                            ),
                            /*child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: userPic,
                              fit: BoxFit.cover,
                              placeholder: (_,__) => Center(child: CircularProgressIndicator(color: Colors.white,),),
                              errorWidget: (_,__,___) => Container(),
                            ),
                          ),*/
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userName, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w500),),
                            //Text(userEmail, textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),),

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black12)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: ListTile(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OnBoard())),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          minLeadingWidth: 0,
                          leading: const Icon(Icons.person, size: 20),
                          title: const Text("Update profile", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),),
                          subtitle: const Text("Update your profile by providing current name, age, height and weight."),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 20),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black12)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: ListTile(
                          onTap: () {
                            showResetDialogBox();
                          },
                          //contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                          minLeadingWidth: 0,
                          leading: const Icon(Icons.restart_alt, size: 20),
                          title: const Text("Reset data", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),),
                          subtitle: const Text("Reset your calories and water intake."),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 20),
                        ),
                      ),
                    ),
                  ]
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}
