import 'package:befit_v2/data/workout_plan_data.dart';
import 'package:befit_v2/data/workout_model.dart';
import 'package:befit_v2/screens/home/workout/beginner/workout_beginner_day_screen.dart';
import 'package:befit_v2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class WorkoutBeginner extends StatefulWidget {
  const WorkoutBeginner({super.key});

  @override
  State<WorkoutBeginner> createState() => _WorkoutBeginnerState();
}

class _WorkoutBeginnerState extends State<WorkoutBeginner> {

  Map<int, List<Workout>> separatedWorkouts = {};

  getWorkoutPlans() {
    for (Workout workout in workoutBeginnerPlan) {
      int day = workout.day!;
      if (separatedWorkouts.containsKey(day)) {
        separatedWorkouts[day]!.add(workout);
      } else {
        separatedWorkouts[day] = [workout];
      }
    }
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
                const SizedBox(height: 15),
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
                        color: appUISecondaryColor.withValues(alpha: 0.5),
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
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 15),
      itemCount: endIndex - startIndex + 1,
      itemBuilder: (context, index) {
        int day = startIndex + index;
        List<Workout> workouts = separatedWorkouts[day] ?? [];

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Material(
              borderRadius: BorderRadius.circular(16),
              color: colorList[index],
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  if(workouts.any((e) => !e.isRelax)) Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutBeginnerDay(workoutPlans: workouts, day: day)));
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.transparent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Day $day", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      workouts.any((e) => e.isRelax)
                          ? Chip(backgroundColor: Colors.green.shade200, avatar: const Icon(FontAwesomeIcons.bed, size: 16,), label: const Text("Relax Day"))
                          : Chip(backgroundColor: Colors.green.shade200, avatar: const Icon(FontAwesomeIcons.clock, size: 16,), label: Text(workouts.isNotEmpty ? workouts.first.dayDuration ?? "" : "")),
                    ],
                  ),
                ),
              ),
            ),
        );
       }
    );
  }
}
