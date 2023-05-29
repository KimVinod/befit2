import 'package:befit_v2/data/workout/beginner/workout_beginner_plan_data.dart';
import 'package:befit_v2/data/workout_model.dart';
import 'package:befit_v2/screens/home/workout/beginner/workout_beginner_day_screen.dart';
import 'package:befit_v2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class WorkoutBeginner extends StatefulWidget {
  const WorkoutBeginner({Key? key}) : super(key: key);

  @override
  State<WorkoutBeginner> createState() => _WorkoutBeginnerState();
}

class _WorkoutBeginnerState extends State<WorkoutBeginner> {

  Map<int, List<Workout>> separatedWorkouts = {};

  getWorkoutPlans() {
    for (Workout workout in workoutBeginnerPlan) {
      int day = workout.day;
      if (separatedWorkouts.containsKey(day)) {
        separatedWorkouts[day]!.add(workout);
      } else {
        separatedWorkouts[day] = [workout];
      }
    }

    /*separatedWorkouts.forEach((day, workouts) {
      print('Day $day:');
      workouts.forEach((workout) => print('${workout.name} - ${workout.gif}'));
      print('');
    });*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWorkoutPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 4,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 22,
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Beginner",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Material(
                  child: TabBar(
                    indicatorColor: Colors.green,
                    tabs: const [
                      Tab(text: "Week 1"),
                      Tab(text: "Week 2"),
                      Tab(text: "Week 3"),
                      Tab(text: "Week 4"),
                    ],
                    unselectedLabelColor: Colors.grey,
                    indicator: RectangularIndicator(
                        color: appUISecondaryColor.withOpacity(0.5),
                        bottomLeftRadius: 100,
                        bottomRightRadius: 100,
                        topLeftRadius: 100,
                        topRightRadius: 100,
                        verticalPadding: 6
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      buildWeekListView(separatedWorkouts, 1),
                      buildWeekListView(separatedWorkouts, 2),
                      buildWeekListView(separatedWorkouts, 3),
                      buildWeekListView(separatedWorkouts, 4),
                      /*ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        itemCount:  separatedWorkouts.length,
                        itemBuilder: (context, index) {
                          int day = separatedWorkouts.keys.elementAt(index);
                          List<Workout> workouts = separatedWorkouts[day]!;
                          if(workouts.any((e) => e.isRelax)) {
                            return Container(
                              height: 200,
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: colorList[index],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Day $day", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                  Chip(backgroundColor: Colors.green.shade200, avatar: Icon(FontAwesomeIcons.bed, size: 16,), label: Text("Relax Day")),
                                ],
                              ),
                            );
                          }else {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutBeginnerDay(workoutPlans: workouts, day: day)));
                              },
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: colorList[index],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Day ${index+1}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                    Chip(backgroundColor: Colors.green.shade200, avatar: Icon(FontAwesomeIcons.clock, size: 16,), label: Text("7 min")),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      ListView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        children: [
                          GestureDetector(
                            onTap: () {
                              List<Workout> workoutPlans = week1.where((e) => e.isRelax == false && e.day == 1).toList();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutBeginnerDay(workoutPlans: workoutPlans, day: 1)));
                            },
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Color(0xffedfdf2),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Day 1", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                  Chip(backgroundColor: Colors.green.shade200, avatar: Icon(FontAwesomeIcons.clock, size: 16,), label: Text("7 min")),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xfffcecec),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Day 2", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                Chip(backgroundColor: Colors.pink.shade100, avatar: Icon(FontAwesomeIcons.bed, size: 16,), label: Text("Relax Day")),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              List<Workout> workoutPlans = week1.where((e) => e.isRelax == false && e.day == 3).toList();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutBeginnerDay(workoutPlans: workoutPlans, day: 3)));
                            },
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Color(0xffedf6fd),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Day 3", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                  Chip(backgroundColor: Colors.blue.shade100, avatar: Icon(FontAwesomeIcons.clock, size: 16,), label: Text("12 min")),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xfffdf5ed),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Day 4", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                Chip(backgroundColor: Color(0xffffd4ae), avatar: Icon(FontAwesomeIcons.bed, size: 16,), label: Text("Relax Day")),
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xffedfdf2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Day 5", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                Chip(backgroundColor: Colors.green.shade200, avatar: Icon(FontAwesomeIcons.bed, size: 16,), label: Text("Relax Day")),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              List<Workout> workoutPlans = week1.where((e) => e.isRelax == false && e.day == 6).toList();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutBeginnerDay(workoutPlans: workoutPlans, day: 6)));
                            },
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Color(0xfffcecec),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Day 6", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                  Chip(backgroundColor: Colors.pink.shade100, avatar: Icon(FontAwesomeIcons.clock, size: 16,), label: Text("7 min")),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xffedf6fd),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Day 7", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                                Chip(backgroundColor: Colors.blue.shade100, avatar: Icon(FontAwesomeIcons.bed, size: 16,), label: Text("Relax Day")),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xffedfdf2),
                            ),
                            child: Stack(
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Knee\nPush-ups", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Chip(avatar: Icon(FontAwesomeIcons.clock, size: 16,), label: Text("30 sec")),
                                        SizedBox(width: 10),
                                        Chip(avatar: Icon(FontAwesomeIcons.repeat, size: 16,), label: Text("5x")),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Gif(
                                      height: 90,
                                      autostart: Autostart.loop,
                                      duration: Duration(milliseconds: 1700),
                                      placeholder: (context) =>
                                      const Center(child: CircularProgressIndicator()),
                                      image: const AssetImage('assets/images/knee-pushups.gif'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xfffcecec),
                            ),
                            child: Stack(
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Forward\nLunges", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Chip(avatar: Icon(FontAwesomeIcons.clock, size: 16,), label: Text("30 sec")),
                                        SizedBox(width: 10),
                                        Chip(avatar: Icon(FontAwesomeIcons.repeat, size: 16,), label: Text("5x")),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Gif(
                                      //height: 90,
                                      autostart: Autostart.loop,
                                      duration: Duration(milliseconds: 4000),
                                      placeholder: (context) =>
                                      const Center(child: CircularProgressIndicator()),
                                      image: const AssetImage('assets/images/forward-lunges.gif'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xffedf6fd),
                            ),
                            child: Stack(
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Mountain\nClimbers", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Chip(avatar: Icon(FontAwesomeIcons.clock, size: 16,), label: Text("30 sec")),
                                        SizedBox(width: 10),
                                        Chip(avatar: Icon(FontAwesomeIcons.repeat, size: 16,), label: Text("5x")),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset('assets/images/mountain-climbers.gif', width: 120,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(),
                      Container(),*/
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWeekListView(Map<int, List<Workout>> separatedWorkouts, int weekNumber) {
    int daysPerWeek = 7;
    int startIndex = (weekNumber - 1) * daysPerWeek + 1;
    int endIndex = startIndex + daysPerWeek - 1;

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 15),
      itemCount: endIndex - startIndex + 1,
      itemBuilder: (context, index) {
        int day = startIndex + index;
        List<Workout> workouts = separatedWorkouts[day] ?? [];
        if(workouts.any((e) => e.isRelax)) {
          return Container(
            height: 200,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: colorList[index],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Day $day", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                Chip(backgroundColor: Colors.green.shade200, avatar: Icon(FontAwesomeIcons.bed, size: 16,), label: Text("Relax Day")),
              ],
            ),
          );
        }else {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutBeginnerDay(workoutPlans: workouts, day: day)));
            },
            child: Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: colorList[index],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Day $day", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  Chip(backgroundColor: Colors.green.shade200, avatar: Icon(FontAwesomeIcons.clock, size: 16,), label: Text(workouts.isNotEmpty ? workouts.first.dayDuration ?? "" : "")),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
