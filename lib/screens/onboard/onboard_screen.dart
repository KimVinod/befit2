import 'package:befit_v2/screens/home/home_screen.dart';
import 'package:befit_v2/utils/constants.dart';
import 'package:befit_v2/utils/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:horizontal_blocked_scroll_physics/horizontal_blocked_scroll_physics.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {

  int _currentIndex = 0;
  late PageController _pageController;
  late Box userDataBox, appUserSettingsBox;
  ScrollPhysics scrollPhysics = const LeftBlockedScrollPhysics();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  List<Color> backgroundColors = [appUIPrimaryColor, appUISecondaryColor, Colors.white, Colors.black];
  List<Color> dotColors = [Colors.white, Colors.black, Colors.black, Colors.white, Colors.white];
  List<Color> dotBgColors = [Colors.black26, Colors.black26, Colors.black26, Colors.white24, Colors.white];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    nameController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void loadData() async {
    userDataBox = await Hive.openBox('userDataBox');
    appUserSettingsBox = await Hive.openBox("appUserSettingsBox");
  }

  Future saveData() async {
    userDataBox.put("name", nameController.text);
    userDataBox.put("age", ageController.text);
    userDataBox.put("height", heightController.text);
    userDataBox.put("weight", weightController.text);
  }

  Color getBackgroundColor() {
    return backgroundColors[_currentIndex];
  }

  Color getDotColor() {
    return dotColors[_currentIndex];
  }

  Color getDotBgColor() {
    return dotBgColors[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: scrollPhysics,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("BeFit", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 28),),
                          const Text("Tell us\nyour name", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 38),),
                          TextField(
                            controller: nameController,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Colors.white)),
                            ),
                          ),
                          Material(
                            color: Colors.black,
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () {
                                if(nameController.text.isNotEmpty) {
                                  setScrollPhysics(scrollPhysics: const ScrollPhysics());
                                  _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut).then((value) {
                                    FocusScope.of(context).unfocus();
                                    setScrollPhysics(scrollPhysics: const LeftBlockedScrollPhysics());
                                  });
                                } else {
                                  setScrollPhysics(scrollPhysics: const LeftBlockedScrollPhysics());
                                  UIComponents.showSnackBar(context, "Name cannot be empty", const Duration(seconds: 3));
                                }

                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.arrow_forward_ios, color: Colors.white,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: GestureDetector(child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onTap: ()=> Navigator.pop(context),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("BeFit", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 28),),
                      const Text("Tell us\nyour age", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 38),),
                      TextField(
                        controller: ageController,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Colors.black)),
                        ),
                      ),
                      Material(
                        color: Colors.black,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            if(ageController.text.isNotEmpty) {
                              setScrollPhysics(scrollPhysics: const ScrollPhysics());
                              _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut).then((value) {
                                FocusScope.of(context).unfocus();
                                setScrollPhysics(scrollPhysics: const LeftBlockedScrollPhysics());
                              });
                            } else {
                              setScrollPhysics(scrollPhysics: const LeftBlockedScrollPhysics());
                              UIComponents.showSnackBar(context, "Age cannot be empty", const Duration(seconds: 3));
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_forward_ios, color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("BeFit", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 28),),
                      const Text("Tell us\nyour height", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 38),),
                      TextField(
                        controller: heightController,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "in cm",
                          hintStyle: const TextStyle(color: Colors.black45),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Colors.black)),
                        ),
                      ),
                      Material(
                        color: Colors.black,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            if(heightController.text.isNotEmpty) {
                              setScrollPhysics(scrollPhysics: const ScrollPhysics());
                              _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut).then((value) {
                                FocusScope.of(context).unfocus();
                                setScrollPhysics(scrollPhysics: const LeftBlockedScrollPhysics());
                              });
                            } else {
                              setScrollPhysics(scrollPhysics: const LeftBlockedScrollPhysics());
                              UIComponents.showSnackBar(context, "Height cannot be empty", const Duration(seconds: 3));
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_forward_ios, color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("BeFit", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 28),),
                      const Text("Tell us\nyour weight", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 38),),
                      TextField(
                        controller: weightController,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "in kg",
                          hintStyle: const TextStyle(color: Colors.white54),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Colors.white)),
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: InkWell(
                          splashColor: Colors.black54,
                          customBorder: const CircleBorder(),
                          onTap: () {
                            if(weightController.text.isNotEmpty) {
                              saveData().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Home()), (route) => false));
                            } else {
                              UIComponents.showSnackBar(context, "Weight cannot be empty", const Duration(seconds: 3));
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_forward_ios, color: Colors.black,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PageViewDotIndicator(
            currentItem: _currentIndex,
            count: 4,
            unselectedColor: getDotBgColor(),
            selectedColor: getDotColor(),
            duration: const Duration(milliseconds: 500),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

   void setScrollPhysics({required ScrollPhysics scrollPhysics}) {
    setState(() {
      this.scrollPhysics = scrollPhysics;
    });
  }
}
