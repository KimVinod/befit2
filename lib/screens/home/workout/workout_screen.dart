import 'package:befit_v2/screens/home/workout/extreme/workout_extreme_screen.dart';
import 'package:befit_v2/screens/home/workout/workout_tips_screen.dart';
import 'package:flutter/material.dart';
import 'beginner/workout_beginner_screen.dart';
import 'intermediate/workout_intermediate_screen.dart';


class Workout extends StatelessWidget {
  const Workout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Column(
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
                    "Workout",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.7, crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutTips())),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFfedffc).withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Workout\nTips", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                const Spacer(),
                                Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/daily-health.png", height: 100,))
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutBeginner())),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFffeeb6).withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Beginner", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                const Text("Weeks: 4", style: TextStyle(fontSize: 13),),
                                const Text("15 min/day", style: TextStyle(fontSize: 13),),
                                const Spacer(),
                                Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/beginner.png", height: 100,))
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutIntermediate())),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFb5ffe5).withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Intermediate", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                const Text("Weeks: 8", style: TextStyle(fontSize: 13),),
                                const Text("45 min/day", style: TextStyle(fontSize: 13),),
                                const Spacer(),
                                Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/intermediate.png", height: 100,))
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkoutExtreme())),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFd1d4f3).withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Extreme", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                const Text("Weeks: 10", style: TextStyle(fontSize: 13),),
                                const Text("90 min/day", style: TextStyle(fontSize: 13),),
                                const Spacer(),
                                Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/extreme.png", height: 100,))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
