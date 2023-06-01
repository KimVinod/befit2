import 'package:befit_v2/data/workout_plan_data.dart';
import 'package:befit_v2/utils/constants.dart';
import 'package:flutter/material.dart';

class WorkoutTips extends StatelessWidget {
  const WorkoutTips({Key? key}) : super(key: key);

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
                    Text(
                      "Workout Tips",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    itemCount: workoutTips.length,
                    itemBuilder: (context, index) => Container(
                      height: 180,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: colorList[index],
                      ),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(workoutTips[index].name, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Spacer(),
                          Text(workoutTips[index].tips, textAlign: TextAlign.center),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
