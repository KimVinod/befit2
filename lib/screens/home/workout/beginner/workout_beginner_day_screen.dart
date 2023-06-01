import 'package:befit_v2/data/workout_model.dart';
import 'package:befit_v2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gif/gif.dart';

class WorkoutBeginnerDay extends StatelessWidget {
  final int day;
  final List<Workout> workoutPlans;
  const WorkoutBeginnerDay({Key? key, required this.workoutPlans, required this.day}) : super(key: key);

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
                      "Day $day",
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
                    itemCount: workoutPlans.length,
                    itemBuilder: (context, index) => Container(
                      height: 200,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: colorList[index],
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(workoutPlans[index].name.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                              Spacer(),
                              Row(
                                children: [
                                  Chip(avatar: Icon(FontAwesomeIcons.clock, size: 16,), label: Text(workoutPlans[index].duration.toString())),
                                  SizedBox(width: 10),
                                  Chip(avatar: Icon(FontAwesomeIcons.repeat, size: 16,), label: Text(workoutPlans[index].reps.toString())),
                                ],
                              ),
                            ],
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Gif(
                                height: workoutPlans[index].gifSize,
                                width: workoutPlans[index].gifSize,
                                autostart: Autostart.loop,
                                duration: Duration(milliseconds: workoutPlans[index].gifDuration!),
                                placeholder: (context) =>
                                const Center(child: CircularProgressIndicator()),
                                image: AssetImage(workoutPlans[index].gif.toString()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                /*Expanded(
                  child: ListView(
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
                                Text("Jumping\nJacks", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                Spacer(),
                                Row(
                                  children: [
                                    Chip(avatar: Icon(FontAwesomeIcons.clock, size: 16,), label: Text("30 sec")),
                                    SizedBox(width: 10),
                                    Chip(avatar: Icon(FontAwesomeIcons.repeat, size: 16,), label: Text("4x")),
                                  ],
                                ),
                              ],
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Gif(
                                  autostart: Autostart.loop,
                                  duration: Duration(milliseconds: 1500),
                                  placeholder: (context) =>
                                  const Center(child: CircularProgressIndicator()),
                                  image: const AssetImage('assets/images/jumping-jacks.gif'),
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
                                Text("Squats", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                Spacer(),
                                Row(
                                  children: [
                                    Chip(avatar: Icon(FontAwesomeIcons.clock, size: 16,), label: Text("30 sec")),
                                    SizedBox(width: 10),
                                    Chip(avatar: Icon(FontAwesomeIcons.repeat, size: 16,), label: Text("4x")),
                                  ],
                                ),
                              ],
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Gif(
                                  autostart: Autostart.loop,
                                  duration: Duration(milliseconds: 1500),
                                  placeholder: (context) =>
                                  const Center(child: CircularProgressIndicator()),
                                  image: const AssetImage('assets/images/squats.gif'),
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
                                Text("High\nPlank", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                Spacer(),
                                Row(
                                  children: [
                                    Chip(avatar: Icon(FontAwesomeIcons.clock, size: 16,), label: Text("30 sec")),
                                    SizedBox(width: 10),
                                    Chip(avatar: Icon(FontAwesomeIcons.repeat, size: 16,), label: Text("4x")),
                                  ],
                                ),
                              ],
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset('assets/images/high-plank.png', width: 120,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
