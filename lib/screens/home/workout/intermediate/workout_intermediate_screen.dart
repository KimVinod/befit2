import 'package:befit_v2/data/workout_plan_data.dart';
import 'package:befit_v2/data/workout_model.dart';
import 'package:befit_v2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gif/gif.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class WorkoutIntermediate extends StatelessWidget {
  const WorkoutIntermediate({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 8,
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
                      "Intermediate",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Text("Perform the following routine on Monday, Wednesday and Friday", textAlign: TextAlign.center),
                const SizedBox(height: 10),
                TabBar(
                  overlayColor: WidgetStateProperty.all(appUISecondaryColor.withValues(alpha: 0.2)),
                  labelColor: Colors.black,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  physics: BouncingScrollPhysics(),
                  tabs: [
                    for (int week = 1; week <= 8; week++)
                      Tab(text: 'Week $week'),
                  ],
                  unselectedLabelColor: Colors.grey,
                  indicator: MaterialIndicator(
                      color: appUISecondaryColor.withValues(alpha: 0.5),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      for (int week = 1; week <= 8; week++)
                        _buildTabContent(week),
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

  Widget _buildTabContent(int week) {
    List<Workout> weekWorkouts = workoutIntermediatePlan.where((workout) => workout.week == week).toList();

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 15),
      itemCount: weekWorkouts.length,
      itemBuilder: (context, index) => Container(
        height: 200,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colorList[index],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(weekWorkouts[index].name.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                const Spacer(),
                Row(
                  children: [
                    Chip(avatar: const Icon(FontAwesomeIcons.clock, size: 16,), label: Text(weekWorkouts[index].duration.toString())),
                    const SizedBox(width: 10),
                    Chip(avatar: const Icon(FontAwesomeIcons.repeat, size: 16,), label: Text(weekWorkouts[index].reps.toString())),
                  ],
                ),
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Gif(
                  height: weekWorkouts[index].gifSize,
                  width: weekWorkouts[index].gifSize,
                  autostart: Autostart.loop,
                  duration: Duration(milliseconds: weekWorkouts[index].gifDuration!),
                  placeholder: (context) =>
                  const Center(child: CircularProgressIndicator()),
                  image: AssetImage(weekWorkouts[index].gif.toString()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
