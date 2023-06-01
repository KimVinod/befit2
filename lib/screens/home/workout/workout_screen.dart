import 'package:befit_v2/screens/home/workout/extreme/workout_extreme_screen.dart';
import 'package:befit_v2/screens/home/workout/workout_tips_screen.dart';
import 'package:flutter/material.dart';
import 'beginner/workout_beginner_screen.dart';
import 'intermediate/workout_intermediate_screen.dart';


class Workout extends StatelessWidget {
  const Workout({Key? key}) : super(key: key);

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
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.7, crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutTips())),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFfedffc).withOpacity(0.7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Workout\nTips", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Spacer(),
                                Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/daily-health.png", height: 100,))
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutBeginner())),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFffeeb6).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Beginner", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Text("Weeks: 4", style: TextStyle(fontSize: 13),),
                                Text("15 min/day", style: TextStyle(fontSize: 13),),
                                Spacer(),
                                Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/beginner.png", height: 100,))
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutIntermediate())),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFb5ffe5).withOpacity(0.55),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Intermediate", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Text("Weeks: 8", style: TextStyle(fontSize: 13),),
                                Text("45 min/day", style: TextStyle(fontSize: 13),),
                                Spacer(),
                                Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/intermediate.png", height: 100,))
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutExtreme())),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFd1d4f3).withOpacity(0.55),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Extreme", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Text("Weeks: 10", style: TextStyle(fontSize: 13),),
                                Text("90 min/day", style: TextStyle(fontSize: 13),),
                                Spacer(),
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
