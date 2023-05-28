import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFfedffc).withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Daily\nWarm-up", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Spacer(),
                              Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/daily-health.png", height: 100,))
                            ],
                          ),
                        ),
                      ),
                      Container(
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
                              Spacer(),
                              Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/beginner.png", height: 100,))
                            ],
                          ),
                        ),
                      ),
                      Container(
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
                              Text("Weeks: 6", style: TextStyle(fontSize: 13),),
                              Spacer(),
                              Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/intermediate.png", height: 100,))
                            ],
                          ),
                        ),
                      ),
                      Container(
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
                              Spacer(),
                              Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/extreme.png", height: 100,))
                            ],
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
