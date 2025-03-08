import 'dart:io';

import 'package:animated_digit/animated_digit.dart';
import 'package:befit_v2/data/meal_data.dart';
import 'package:befit_v2/data/meal_model.dart';
import 'package:befit_v2/screens/home/workout/workout_screen.dart';
import 'package:befit_v2/screens/profile/profile_screen.dart';
import 'package:befit_v2/services/water_reminder.dart';
import 'package:befit_v2/utils/constants.dart';
import 'package:befit_v2/utils/ui_components.dart';
import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final fabKey = GlobalKey<ExpandableFabState>();
  final List<Meal> meals = allMeals;
  late Box userDataBox, userFitnessDataBox, appUserSettingsBox;
  int totalWaterML = 0, waterGoalML = 3000;
  int totalCaloriesKCAL = 0, caloriesGoalKCAL = 2300;
  String userName = '', userAge = "",userPic = '', date = '';
  int userHeight = 0, userWeight = 0;
  bool isFirstRun = true;

  AnimatedDigitController scoreController = AnimatedDigitController(0);

  BuildContext? showCaseContext;
  final _welcomeKey = GlobalKey();
  final _waterKey = GlobalKey();
  final _caloriesKey = GlobalKey();
  final _bmiKey = GlobalKey();
  final _scoreKey = GlobalKey();
  final _workoutKey = GlobalKey();
  final _profileKey = GlobalKey();

  Future loadData() async {
    userDataBox = await Hive.openBox("userDataBox");
    userFitnessDataBox = await Hive.openBox("userFitnessDataBox");
    appUserSettingsBox = await Hive.openBox("appUserSettingsBox");

    String todayDate = DateTime.now().toIso8601String().substring(0,10);

    setState(() {
      isFirstRun = appUserSettingsBox.get("isFirstRun", defaultValue: true);
      date = userDataBox.get("day", defaultValue: "");
      if(date != todayDate) {
        clearFitnessData().then((value) => userDataBox.put("day", todayDate));
      } else {
        totalWaterML = userFitnessDataBox.get("water", defaultValue: 0);
        totalCaloriesKCAL = userFitnessDataBox.get("calories", defaultValue: 0);
      }
      userName = userDataBox.get("name", defaultValue: "");
      userAge = userDataBox.get("age", defaultValue: "");
      userPic = userDataBox.get("profilePic", defaultValue: "");
      userHeight = double.parse(userDataBox.get("height", defaultValue: 0)).toInt();
      userWeight = double.parse(userDataBox.get("weight", defaultValue: 0)).toInt();
    });
  }

  Future clearFitnessData() async {
    userFitnessDataBox = await Hive.openBox("userFitnessDataBox");
    await userFitnessDataBox.clear();
  }

  void showShowCaseView() {
    ShowCaseWidget.of(showCaseContext!).startShowCase([
      _welcomeKey,
      _workoutKey,
      _waterKey,
      _caloriesKey,
      _bmiKey,
      _scoreKey,
      _profileKey,
    ]);
    appUserSettingsBox.put("isFirstRun", false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadData().then((value) {
        if(isFirstRun) showShowCaseView();
        displayScore(bmi: getBMI(), water: totalWaterML / 1000, calories: totalCaloriesKCAL);
      });
      setState(() { });
    });
  }

  int setStateForWater({required int currentWater}) {
    setState(() {
      totalWaterML = totalWaterML + currentWater;
    });
    return totalWaterML;
  }

  int setStateForCalories({required int currentCalories}) {
    setState(() {
      totalCaloriesKCAL = totalCaloriesKCAL + currentCalories;
    });
    return totalCaloriesKCAL;
  }

  String getWishingText() {
    final dateTimeInHour = DateTime.now().hour;
    if (dateTimeInHour >= 5 && dateTimeInHour < 12) {
      return "Good Morning";
    } else if (dateTimeInHour >= 12 && dateTimeInHour < 17) {
      return "Good Afternoon";
    } else if (dateTimeInHour >= 17 && dateTimeInHour < 21) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ShowCaseWidget(
        builder: (context) {
          showCaseContext = context;
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Showcase(
                          key: _welcomeKey,
                          titleTextAlign: TextAlign.center,
                          descriptionTextAlign: TextAlign.center,
                          title: 'Welcome to BeFit',
                          description: 'Track and maintain your fitness life with us.\nHave a good day! Take care!',
                          child: const Text(
                            "BeFit",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: appUIPrimaryColor,
                            ),
                          ),
                        ),
                        Showcase(
                          key: _profileKey,
                          descriptionTextAlign: TextAlign.center,
                          description: 'You can set your profile and other settings from here!',
                          child: Material(
                            color: appUIPrimaryColor.withValues(alpha: 0.11),
                            shape: const CircleBorder(),
                            child: InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile())).then((value) => loadData()),
                              customBorder: const CircleBorder(),
                              child: ClipOval(
                                child: Container(
                                  height: 65,
                                  width: 65,
                                  decoration:  const BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle
                                  ),
                                  child: userPic =="" ? const Icon(Icons.person_outline, size: 28)
                                      : Image.file(
                                    File(userPic),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, _, __) => const Center(child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.person_outline, size: 28),
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(getWishingText(), style: const TextStyle(fontSize: 33, fontWeight: FontWeight.w300)),
                    if(userName.isNotEmpty)...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Text("Mr. ", style: TextStyle(fontSize: 33, fontWeight: FontWeight.w300)),
                          Text(userName, style: const TextStyle(fontSize: 33, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                    const SizedBox(height: 15),
                    StaggeredGrid.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 12,
                      children: [
                        Showcase(
                          key: _waterKey,
                          descriptionTextAlign: TextAlign.center,
                          description: 'Your water intake is shown here!',
                          child: GestureDetector(
                            onTap: ()=>showWaterDialogBox(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: appUILightBlueColor,
                                //border: Border.all(color: Colors.grey.shade300, width: 1.5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Water", style: TextStyle(fontSize: 18, color: appUIDarkBlueColor),),
                                      Icon(Icons.water_drop_outlined, size: 22, color: appUIDarkBlueColor,),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: TweenAnimationBuilder(
                                            tween: Tween(begin: 0, end: totalWaterML / waterGoalML),
                                            duration: const Duration(seconds: 2),
                                            builder: (context, value, _) {
                                              return CircularProgressIndicator(
                                                value: value.toDouble(),
                                                color: appUIDarkBlueColor,
                                                strokeWidth: 3,
                                                backgroundColor: Colors.lightBlue.shade100,
                                              );
                                            }
                                        ),
                                      ),
                                      Text("${totalWaterML / 1000 == 0 ? 0 : totalWaterML / 1000} L", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: appUIDarkBlueColor),),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  if(totalWaterML >= 1500)...[
                                    const Text("You're doing well ♡", style: TextStyle(fontSize: 16, color: appUIDarkBlueColor),),
                                  ] else... [
                                    const Text("Keep on going ♡", style: TextStyle(fontSize: 16, color: appUIDarkBlueColor),),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                        Showcase(
                          key: _workoutKey,
                          descriptionTextAlign: TextAlign.center,
                          description: 'Workout plans are shown here!',
                          child: GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Workout())),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                              decoration: BoxDecoration(
                                color: appUILLightGreenColor.withValues(alpha: 0.65),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Workout", style: TextStyle(fontSize: 18, color: Colors.teal.shade900),),
                                      Icon(FontAwesomeIcons.dumbbell, size: 17, color: Colors.teal.shade900,),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.teal.shade100, width: 3)
                                    ),
                                    child: Center(child: Icon(FontAwesomeIcons.personRunning, size: 30, color: Colors.teal.shade900,)),
                                    //child: Center(child: Text("", style: TextStyle(fontSize: 20, color: Colors.teal.shade900))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Showcase(
                          key: _caloriesKey,
                          descriptionTextAlign: TextAlign.center,
                          description: 'Your calorie intake is shown here!',
                          child: GestureDetector(
                            onTap: ()=>showCaloriesDialogBox(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                              ),
                              child: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Calories", style: TextStyle(fontSize: 18, color: appUISecondaryColor),),
                                      Icon(Icons.fastfood_outlined, size: 18, color: appUISecondaryColor,),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: TweenAnimationBuilder(
                                            tween: Tween(begin: 0, end: totalCaloriesKCAL / caloriesGoalKCAL),
                                            duration: const Duration(seconds: 2),
                                            builder: (context, value, _) {
                                              return CircularProgressIndicator(
                                                value: value.toDouble(),
                                                color: appUISecondaryColor,
                                                strokeWidth: 3,
                                                backgroundColor: Colors.orange.shade100,
                                              );
                                            }
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text("$totalCaloriesKCAL kcal", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: appUISecondaryColor),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Showcase(
                          key: _bmiKey,
                          descriptionTextAlign: TextAlign.center,
                          description: 'Your BMI is shown here!',
                          child: GestureDetector(
                            onTap: () => showBMIDialogBox(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: appUILightBrownColor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("BMI", style: TextStyle(fontSize: 18, color: appUIBrownColor),),
                                      Icon(FontAwesomeIcons.childReaching, size: 20, color: appUIBrownColor,),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Text("${getBMI()} ", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w300, color: appUIBrownColor),),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text("$userHeight ", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w300, color: appUIBrownColor),),
                                      const Text("cm", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300, color: appUIBrownColor),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("$userWeight ", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w300, color: appUIBrownColor),),
                                      const Text("kg", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300, color: appUIBrownColor),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("$userAge ", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w300, color: appUIBrownColor),),
                                      const Text("age", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300, color: appUIBrownColor),),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                        Showcase(
                          key: _scoreKey,
                          descriptionTextAlign: TextAlign.center,
                          description: 'Your score is shown here!\nThis shows your overall performance of the day out of 100.',
                          child: GestureDetector(
                            onTap: () => showScoreDialogBox(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                              decoration: BoxDecoration(
                                color: appUILavenderColor.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                              ),
                              child: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Score", style: TextStyle(fontSize: 18, color: appUIDarkPurpleColor),),
                                      Icon(Icons.scoreboard_outlined, size: 19, color: appUIDarkPurpleColor,),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: TweenAnimationBuilder(
                                            tween: Tween(begin: 0, end: calculateScore(bmi: getBMI(), calories: totalCaloriesKCAL, water: totalWaterML/1000) / 100),
                                            duration: const Duration(seconds: 2),
                                            builder: (context, value, _) {
                                              return CircularProgressIndicator(
                                                value: value.toDouble(),
                                                color: appUIDarkPurpleColor,
                                                strokeWidth: 3,
                                                backgroundColor: appUIDarkPurpleColor.withValues(alpha: 0.2),
                                              );
                                            }
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Countup(
                                            begin: 0,
                                            end: calculateScore(bmi: getBMI(), calories: totalCaloriesKCAL, water: totalWaterML/1000).toDouble(),
                                            duration: const Duration(seconds: 2),
                                            style: const TextStyle(
                                              fontSize: 32,
                                              color: appUIDarkPurpleColor,
                                            ),
                                          )
                                          /*AnimatedDigitWidget(
                                                controller: scoreController,
                                                  duration: Duration(seconds: 2),
                                                  value: calculateScore(bmi: getBMI(), calories: totalCaloriesKCAL, water: totalWaterML/1000),
                                              ),*/
                                          //Text(calcexitulateScore(bmi: getBMI(), calories: totalCaloriesKCAL, water: totalWaterML/1000).toString(), style: TextStyle(fontSize: 32, color: appUIDarkPurpleColor),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: fabKey,
        openButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Icons.add, size: 30, color: Colors.white,),
          backgroundColor: Colors.black,
          heroTag: 'open'
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Icons.add, size: 30, color: Colors.white,),
          backgroundColor: Colors.black,
          heroTag: 'close'
        ),
        fanAngle: 90,
        overlayStyle: ExpandableFabOverlayStyle(blur: 3),
        children: [
          FloatingActionButton(
            backgroundColor: appUISecondaryColor,
            heroTag: 'meal',
            tooltip: "Meal",
            child: const Icon(Icons.fastfood_outlined, color: Colors.black,),
            onPressed: () {
              final state = fabKey.currentState;
              if (state != null) {
                state.toggle();
                showAddMealModalBottomSheet();
              }
            },
          ),
          FloatingActionButton(
            backgroundColor: appUILightBlueColor,
            tooltip: "Water",
            heroTag: 'water',
            child: const Icon(Icons.water_drop_outlined, size: 28, color: appUIDarkBlueColor,),
            onPressed: () {
              final state = fabKey.currentState;
              if (state != null) {
                state.toggle();
                showAddWaterModalBottomSheet();
              }
            },
          ),
          FloatingActionButton(
            backgroundColor: appUILavenderColor,
            heroTag: 'notfs',
            tooltip: "Reminder",
            child: const Icon(FontAwesomeIcons.bell, color: appUIDarkPurpleColor,),
            onPressed: () {
              final state = fabKey.currentState;
              if (state != null) {
                state.toggle();
                showAddReminderModalBottomSheet();
              }
            },
          ),
        ],
      ),
    );
  }

  void showWaterDialogBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: appUILightBlueColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Water Intake", style: TextStyle(fontSize: 20, color: appUIDarkBlueColor),),
                  Icon(Icons.water_drop_outlined, size: 24, color: appUIDarkBlueColor,),
                ],
              ),
              //const SizedBox(height: 25),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: TweenAnimationBuilder(
                        tween: Tween(begin: 0, end: totalWaterML / waterGoalML),
                        duration: const Duration(seconds: 2),
                        builder: (context, value, _) {
                          return CircularProgressIndicator(
                            value: value.toDouble(),
                            color: appUIDarkBlueColor,
                            strokeWidth: 3,
                            backgroundColor: Colors.lightBlue.shade100,
                          );
                        }
                    ),
                  ),
                  Text("${totalWaterML / 1000 == 0 ? 0 : totalWaterML / 1000} L", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: appUIDarkBlueColor),),
                ],
              ),
              const Text("It is recommended to drink 3 liters of water daily.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: appUIDarkBlueColor),),
              //const SizedBox(height: 25),
              if(totalWaterML >= 1500)...[
                const Text("You're doing well ♡", style: TextStyle(fontSize: 16, color: appUIDarkBlueColor),),
              ] else... [
                const Text("Keep on going ♡", style: TextStyle(fontSize: 16, color: appUIDarkBlueColor),),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void showCaloriesDialogBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Calorie Intake", style: TextStyle(fontSize: 20, color: appUISecondaryColor),),
                  Icon(Icons.fastfood_outlined, size: 22, color: appUISecondaryColor,),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: TweenAnimationBuilder(
                        tween: Tween(begin: 0, end: totalCaloriesKCAL / caloriesGoalKCAL),
                        duration: const Duration(seconds: 2),
                        builder: (context, value, _) {
                          return CircularProgressIndicator(
                            value: value.toDouble(),
                            color: appUISecondaryColor,
                            strokeWidth: 3,
                            backgroundColor: Colors.orange.shade100,
                          );
                        }
                    ),
                  ),
                  Column(
                    children: [
                      Text("$totalCaloriesKCAL kcal", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: appUISecondaryColor),),
                    ],
                  ),
                ],
              ),
              const Text("It is recommended to consume around 2300 kcal everyday.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: appUISecondaryColor),),
            ],
          ),
        ),
      ),
    );
  }

  void showScoreDialogBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: appUILavenderColor
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Score", style: TextStyle(fontSize: 20, color: appUIDarkPurpleColor),),
                  Icon(Icons.scoreboard_outlined, size: 24, color: appUIDarkPurpleColor,),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: TweenAnimationBuilder(
                        tween: Tween(begin: 0, end: calculateScore(bmi: getBMI(), calories: totalCaloriesKCAL, water: totalWaterML/1000) / 100),
                        duration: const Duration(seconds: 2),
                        builder: (context, value, _) {
                          return CircularProgressIndicator(
                            value: value.toDouble(),
                            color: appUIDarkPurpleColor,
                            strokeWidth: 3,
                            backgroundColor: appUIDarkPurpleColor.withValues(alpha: 0.2),
                          );
                        }
                    ),
                  ),
                  Column(
                    children: [
                      Countup(
                        begin: 0,
                        end: calculateScore(bmi: getBMI(), calories: totalCaloriesKCAL, water: totalWaterML/1000).toDouble(),
                        duration: const Duration(seconds: 2),
                        style: const TextStyle(
                          fontSize: 42,
                          color: appUIDarkPurpleColor,
                        ),
                      )
                      /*AnimatedDigitWidget(
                                      controller: scoreController,
                                        duration: Duration(seconds: 2),
                                        value: calculateScore(bmi: getBMI(), calories: totalCaloriesKCAL, water: totalWaterML/1000),
                                    ),*/
                      //Text(calcexitulateScore(bmi: getBMI(), calories: totalCaloriesKCAL, water: totalWaterML/1000).toString(), style: TextStyle(fontSize: 32, color: appUIDarkPurpleColor),),
                    ],
                  ),
                ],
              ),
              const Text("Try to maintain score of 85 and above to stay fit and healthy.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: appUIDarkPurpleColor),),
            ],
          ),
        ),
      ),
    );
  }

  void showBMIDialogBox() {
    String bmiText = "";
    double bmi = getBMI();
    if(bmi < 18.5) {
      bmiText = "You are underweight";
    } else if(bmi >= 18.5 && bmi <=25) {
      bmiText = "You have nominal weight";
    } else if(bmi >= 25 && bmi <=30) {
      bmiText = "You are overweight";
    } else {
      bmiText = "You fall within the obesity range";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: appUILightBrownColor
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your BMI", style: TextStyle(fontSize: 20, color: appUIBrownColor),),
                  Icon(FontAwesomeIcons.childReaching, size: 24, color: appUIBrownColor,),
                ],
              ),
              Column(
                children: [
                  Text(bmi.toString(), style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w300, color: appUIBrownColor),),
                  const SizedBox(height: 5),
                  Text(bmiText, style: const TextStyle(fontSize: 18, color: appUIBrownColor),),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$userHeight ", style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w300, color: appUIBrownColor),),
                      const Text("cm", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300, color: appUIBrownColor),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$userWeight ", style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w300, color: appUIBrownColor),),
                      const Text("kg", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300, color: appUIBrownColor),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$userAge ", style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w300, color: appUIBrownColor),),
                      const Text("age", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300, color: appUIBrownColor),),
                    ],
                  ),
                ],
              ),
              const Text("A BMI within the range of 18.5 to 24.9 is considered to be in the healthy range.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: appUIBrownColor),),
            ],
          ),
        ),
      ),
    );
  }

  void showAddWaterModalBottomSheet() {
    int n = 1, selectedType = 0;
    String selectedTextType = "Water";
    TextEditingController waterController = TextEditingController(text: "250");
    showBarModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    const Text("What did you drink?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 85,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            color: selectedType == 0 ? appUILightBlueColor : Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  selectedType = 0;
                                  selectedTextType = "Water";
                                });
                              },
                              child: Container(
                                width: 80,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade400, width: 1.5)),
                                child: const Column(
                                  children: [
                                    Icon(FontAwesomeIcons.glassWater, color: appUIDarkBlueColor,),
                                    SizedBox(height: 4),
                                    Text("Water", style: TextStyle(color: appUIDarkBlueColor),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            color: selectedType == 1 ? appUIPrimaryColor.withValues(alpha: 0.15) : Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  selectedType = 1;
                                  selectedTextType = "Coke";
                                });
                              },
                              child: Container(
                                width: 80,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade400, width: 1.5)),
                                child: const Column(
                                  children: [
                                    Icon(FontAwesomeIcons.wineGlass, color: appUIPrimaryColor,),
                                    SizedBox(height: 4),
                                    Text("Coke", style: TextStyle(color: appUIPrimaryColor),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            color: selectedType == 2 ? appUILightBrownColor : Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  selectedType = 2;
                                  selectedTextType = "Coffee";
                                });
                              },
                              child: Container(
                                width: 80,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade400, width: 1.5)),
                                child: const Column(
                                  children: [
                                    Icon(FontAwesomeIcons.mugHot, color: appUIBrownColor,),
                                    SizedBox(height: 4),
                                    Text("Coffee", style: TextStyle(color: appUIBrownColor),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            color: selectedType == 3 ? appUILavenderColor.withValues(alpha: 0.8) : Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  selectedType = 3;
                                  selectedTextType = "Liquor";
                                });
                              },
                              child: Container(
                                width: 80,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade400, width: 1.5)),
                                child: const Column(
                                  children: [
                                    Icon(FontAwesomeIcons.martiniGlass, color: appUIDarkPurpleColor,),
                                    SizedBox(height: 4),
                                    Text("Liquor", style: TextStyle(color: appUIDarkPurpleColor),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 25,
                      child: WaveWidget(
                        config: CustomConfig(
                          colors: [
                            Colors.blue[400]!,
                            Colors.blue[300]!,
                            Colors.blue[200]!,
                            Colors.blue[100]!
                          ],
                          durations: [18000, 8000, 5000, 12000],
                          heightPercentages: [0.65, 0.66, 0.68, 0.70],
                        ),
                        size: const Size(double.infinity, double.infinity),
                        waveAmplitude: 0,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              if(n!=1) setState(()=> n--);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8),  border: Border.all(color: Colors.grey.shade400, width: 1.5)),
                              child: const Icon(Icons.remove),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const Icon(Icons.water_drop_outlined),
                            Text("${n}x $selectedTextType"),
                            const SizedBox(height: 10),
                            SizedBox(
                                width: 80,
                                child: TextFormField(
                                  controller: waterController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    suffixText: "ml",
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    border: OutlineInputBorder(gapPadding: 0),
                                  ),
                                )
                            ),
                          ],
                        ),
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              setState(()=> n++);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade400, width: 1.5)),
                              child: const Center(child: Icon(Icons.add)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CupertinoButton(
                      onPressed: () {
                        int currentWaterML = n * int.parse(waterController.text);
                        totalWaterML = setStateForWater(currentWater: currentWaterML);
                        userFitnessDataBox.put("water", totalWaterML).then((value) => context.mounted ? Navigator.pop(context) : {});
                      },
                      color: appUIPrimaryColor,
                      borderRadius: BorderRadius.circular(12),
                      child: const Text("ADD", style: TextStyle(fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  void showAddMealModalBottomSheet() {
    String searchText = "";
    List<Meal> selectedMeals = [];
    showBarModalBottomSheet(context: context, builder: (context) => StatefulBuilder(
     builder: (context, setState) => Padding(
       padding: MediaQuery.of(context).viewInsets,
       child: Column(
         children: [
           Padding(
             padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
             child: Row(
               children: [
                 GestureDetector(
                 onTap: ()=> Navigator.pop(context),
                   child: Container(
                     height: 55,
                     width: 50,
                     margin: const EdgeInsets.only(right: 8),
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey),
                       borderRadius: BorderRadius.circular(8),
                     ),
                     child: const Center(child: Icon(FontAwesomeIcons.chevronLeft, color: Colors.black, size: 20,),),
                   ),
                 ),
                 Expanded(
                   child: TextFormField(
                     onChanged: (val) => setState(() => searchText = val),
                     decoration: InputDecoration(
                       labelText: 'Search meals',
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                       suffixIcon: const Icon(
                         Icons.search,
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           ),
           const SizedBox(height: 10),
           Expanded(
             child: ListView.builder(
               physics: const BouncingScrollPhysics(),
               padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
               itemCount: meals.length,
               itemBuilder: (context, index) {
                 final meal = meals[index];
                 if(meal.name.toLowerCase().contains(searchText.toLowerCase())) {
                   bool isChecked = selectedMeals.contains(meal);
                   return Padding(
                     padding: const EdgeInsets.only(bottom: 20),
                     child: GestureDetector(
                       onTap: () {
                         if(selectedMeals.contains(meal)) {
                           selectedMeals.remove(meal);
                           setState(() => isChecked = false);
                         } else {
                           selectedMeals.add(meal);
                           setState(() => isChecked = true);
                         }
                       },
                       child: Material(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(8),
                         elevation: 10,
                         child: Container(
                           width: double.infinity,
                           padding: const EdgeInsets.all(12),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(8)
                           ),
                           child: Column(
                             children: [
                               Row(
                                 children: [
                                   Container(
                                     height: 60,
                                     width: 60,
                                     margin: const EdgeInsets.only(right: 10),
                                     decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                                   ),
                                   Column(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(meal.name, style: const TextStyle(fontSize: 16)),
                                       Row(
                                         children: [
                                           Icon(FontAwesomeIcons.fire, size: 15, color: Colors.red.shade400,),
                                           const SizedBox(width: 4),
                                           Text("${meal.calories} kcal", style: const TextStyle(fontSize: 13, color: Colors.grey)),
                                           const SizedBox(width: 16),
                                           Icon(FontAwesomeIcons.bagShopping, size: 15, color: Colors.grey.shade400,),
                                           const SizedBox(width: 4),
                                           Text("${meal.quantity} ${meal.quantityType}", style: const TextStyle(fontSize: 13, color: Colors.grey)),
                                         ],
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                               const SizedBox(height: 8),
                               Row(
                                 children: [
                                   SizedBox(
                                       height: 50,
                                       width: 8,
                                       child: FAProgressBar(
                                         currentValue: 50,
                                         maxValue: 100,
                                         backgroundColor: Colors.grey.shade300,
                                         progressColor: Colors.blue.shade400,
                                         animatedDuration: const Duration(milliseconds: 2000),
                                         direction: Axis.vertical,
                                         verticalDirection: VerticalDirection.up,
                                       )
                                   ),
                                   const SizedBox(width: 10),
                                   SizedBox(
                                     height: 55,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.end,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text("${meal.carbs} g"),
                                         const Text("Carbs", style: TextStyle(fontSize: 13, color: Colors.grey)),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(width: 20),
                                   SizedBox(
                                       height: 50,
                                       width: 8,
                                       child: FAProgressBar(
                                         currentValue: 50,
                                         maxValue: 100,
                                         backgroundColor: Colors.grey.shade300,
                                         progressColor: Colors.green.shade400,
                                         animatedDuration: const Duration(milliseconds: 2000),
                                         direction: Axis.vertical,
                                         verticalDirection: VerticalDirection.up,
                                       )
                                   ),
                                   const SizedBox(width: 10),
                                   SizedBox(
                                     height: 55,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.end,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text("${meal.protein} g"),
                                         const Text("Protein", style: TextStyle(fontSize: 13, color: Colors.grey)),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(width: 20),
                                   SizedBox(
                                       height: 50,
                                       width: 8,
                                       child: FAProgressBar(
                                         currentValue: 50,
                                         maxValue: 100,
                                         backgroundColor: Colors.grey.shade300,
                                         progressColor: Colors.red.shade400,
                                         animatedDuration: const Duration(milliseconds: 2000),
                                         direction: Axis.vertical,
                                         verticalDirection: VerticalDirection.up,
                                       )
                                   ),
                                   const SizedBox(width: 10),
                                   SizedBox(
                                     height: 55,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.end,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text("${meal.fat} g"),
                                         const Text("Fat", style: TextStyle(fontSize: 13, color: Colors.grey)),
                                       ],
                                     ),
                                   ),
                                   const Spacer(),
                                   SizedBox(
                                     height: 55,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.end,
                                       children: [
                                         RoundCheckBox(
                                           size: 28,
                                           isChecked: isChecked,
                                           animationDuration: const Duration(milliseconds: 200),
                                           onTap: (val) {
                                             if(val!) {
                                               selectedMeals.add(meal);
                                             } else {
                                               selectedMeals.remove(meal);
                                             }
                                           },
                                         ),
                                       ],
                                     ),
                                   ),
                                 ],
                               )
                             ],
                           ),
                         ),
                       ),
                     ),
                   );
                 } else {
                   return Container();
                 }
               },
             ),
           ),
           const SizedBox(height: 10),
           CupertinoButton(
             onPressed: () {
               if(selectedMeals.isNotEmpty) {
                 int currentCaloriesKCAL = selectedMeals.map((meal) => meal.calories).reduce((a, b) => a+b);
                 totalCaloriesKCAL = setStateForCalories(currentCalories: currentCaloriesKCAL);
                 userFitnessDataBox.put("calories", totalCaloriesKCAL).then((value) => context.mounted ? Navigator.pop(context) : {});
               }
             },
             color: appUIPrimaryColor,
             borderRadius: BorderRadius.circular(12),

             child: const Text("ADD", style: TextStyle(fontWeight: FontWeight.w500)),
           ),
           const SizedBox(height: 10),
         ],
       ),
     ),
    ));
  }

  Future<void> showAddReminderModalBottomSheet() async {
    final isActive = await WaterReminder.isReminderActive();
    if(!mounted) return;
    if(isActive) {
      int selectedType = 1;
      showBarModalBottomSheet(context: context, builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                height: MediaQuery.of(context).size.height * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Text("Remind me to drink water", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                    const SizedBox(height: 30),
                    const Text("Choose time interval", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 90,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            color: selectedType == 0 ? appUILightBlueColor : Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  selectedType = 0;
                                });
                              },
                              child: Container(
                                width: 85,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade400, width: 1.5)),
                                child: const Column(
                                  children: [
                                    Icon(FontAwesomeIcons.bellSlash, color: appUIDarkBlueColor, size: 22,),
                                    SizedBox(height: 12),
                                    Text("Disable", style: TextStyle(color: appUIDarkBlueColor),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            color: selectedType == 1 ? appUILightBlueColor : Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  selectedType = 1;
                                });
                              },
                              child: Container(
                                width: 85,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade400, width: 1.5)),
                                child: const Column(
                                  children: [
                                    Icon(FontAwesomeIcons.bell, color: appUIDarkBlueColor, size: 22,),
                                    SizedBox(height: 12),
                                    Text("1 hr", style: TextStyle(color: appUIDarkBlueColor),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: CupertinoButton(
                        onPressed: () {
                          if(selectedType == 0) {
                            WaterReminder.cancel().then((value) => context.mounted ? Navigator.pop(context)  : {});
                          } else {
                            WaterReminder.remindHourly().then((value) {
                              if(!context.mounted) return;
                              UIComponents.showSnackBar(context, "Reminder added!", const Duration(seconds: 3));
                              Navigator.pop(context);
                            });
                          }
                        },
                        color: appUIPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                        child: const Text("SET", style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ));
    } else {
      int selectedType = 0;
      showBarModalBottomSheet(context: context, builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                height: MediaQuery.of(context).size.height * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Text("Remind me to drink water", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                    const SizedBox(height: 30),
                    const Text("Choose time interval", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 90,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            color: selectedType == 0 ? appUILightBlueColor : Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  selectedType = 0;
                                });
                              },
                              child: Container(
                                width: 85,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade400, width: 1.5)),
                                child: const Column(
                                  children: [
                                    Icon(FontAwesomeIcons.bellSlash, color: appUIDarkBlueColor, size: 22,),
                                    SizedBox(height: 12),
                                    Text("Disable", style: TextStyle(color: appUIDarkBlueColor),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Material(
                            borderRadius: BorderRadius.circular(8),
                            color: selectedType == 1 ? appUILightBlueColor : Colors.white,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  selectedType = 1;
                                });
                              },
                              child: Container(
                                width: 85,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade400, width: 1.5)),
                                child: const Column(
                                  children: [
                                    Icon(FontAwesomeIcons.bell, color: appUIDarkBlueColor, size: 22,),
                                    SizedBox(height: 12),
                                    Text("1 hr", style: TextStyle(color: appUIDarkBlueColor),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: CupertinoButton(
                        onPressed: () {
                          if(selectedType == 0) {
                            WaterReminder.cancel().then((value) => context.mounted ? Navigator.pop(context)  : {});
                          } else {
                            WaterReminder.remindHourly().then((value) {
                              if(!context.mounted) return;
                              Navigator.pop(context);
                              UIComponents.showSnackBar(context, "Reminder added!", const Duration(seconds: 3));
                            });
                          }
                        },
                        color: appUIPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                        child: const Text("SET", style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ));
    }
  }

  double getBMI() {
    return (userWeight / ((userHeight/100) * (userHeight/100))).toPrecision(1);
  }

  int calculateScore({required double bmi, required double water, required int calories}) {
    return calculateBmiScore(bmi) + calculateWaterScore(water) + calculateCaloriesScore(calories);
  }

  void displayScore({required double bmi, required double water, required int calories}) {
    scoreController.addValue(calculateBmiScore(bmi) + calculateWaterScore(water) + calculateCaloriesScore(calories));
  }

  int calculateBmiScore(double bmi) {
    if (bmi >= 35) {
      return 10;
    } else if (bmi >= 30) {
      return 15;
    } else if (bmi >= 28) {
      return 17;
    } else if (bmi >= 26) {
      return 20;
    } else if (bmi >= 25) {
      return 23;
    } else if (bmi >= 24) {
      return 25;
    } else if (bmi >= 23) {
      return 27;
    } else if (bmi >= 22) {
      return 30;
    } else if (bmi >= 21) {
      return 27;
    } else if (bmi >= 20) {
      return 25;
    } else if (bmi >= 19) {
      return 23;
    } else if (bmi >= 18) {
      return 20;
    } else if (bmi >= 17) {
      return 17;
    } else if (bmi >= 16) {
      return 15;
    } else if (bmi >= 14) {
      return 13;
    } else if (bmi > 0) {
      return 10;
    } else {
      return 0;
    }
  }

  int calculateWaterScore(double water) {
    if (water >= 5) {
      return 35;
    } else if (water >= 3) {
      return 35;
    } else if (water >= 2.9) {
      return 33;
    } else if (water >= 2.8) {
      return 31;
    } else if (water >= 2.6) {
      return 29;
    } else if (water >= 2.4) {
      return 27;
    } else if (water >= 2.2) {
      return 25;
    } else if (water >= 2) {
      return 23;
    } else if (water >= 1.8) {
      return 20;
    } else if (water >= 1.6) {
      return 17;
    } else if (water >= 1.4) {
      return 15;
    } else if (water >= 1.2) {
      return 13;
    } else if (water >= 1) {
      return 11;
    } else if (water >= 0.8) {
      return 9;
    } else if (water >= 0.6) {
      return 7;
    } else if (water >= 0.4) {
      return 5;
    } else if (water >= 0.2) {
      return 3;
    } else if (water >= 0.1) {
      return 1;
    } else {
      return 0;
    }
  }

  int calculateCaloriesScore(int calories) {
    if(calories >= 4000) {
      return 10;
    } else if(calories >= 3000) {
      return 20;
    } else if(calories >= 2700) {
      return 27;
    } else if(calories >= 2450) {
      return 32;
    } else if(calories >= 2200) {
      return 35;
    } else if(calories >= 2000) {
      return 33;
    } else if(calories >= 1900) {
      return 30;
    } else if(calories >= 1800) {
      return 27;
    } else if(calories >= 1700) {
      return 23;
    } else if(calories >= 1600) {
      return 20;
    } else if(calories >= 1500) {
      return 17;
    } else if(calories >= 1400) {
      return 15;
    } else if(calories >= 1300) {
      return 13;
    } else if(calories >= 1200) {
      return 10;
    } else if(calories >= 1100) {
      return 7;
    } else if(calories >= 900) {
      return 5;
    } else if(calories >= 700) {
      return 3;
    } else if(calories >= 500) {
      return 2;
    } else if(calories >= 300) {
      return 1;
    } else {
      return 0;
    }
  }
  
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
