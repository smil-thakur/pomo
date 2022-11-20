import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomo/methods/pomo_methods.dart';
import 'package:pomo/screens/aboutme_screen.dart';
import 'package:pomo/screens/setting_screen.dart';

bool darkMode = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void changeWorkTime(int workTimeup) {
    workTime = workTimeup;
    if (workTime <= 9) {
      worktimestr = "0$workTime";
    } else {
      worktimestr = workTime.toString();
    }
    if (pomotime[0] != "00" || pomotime[1] != "00") {
      stop();
    }
    start = 0;
    pomotime = ["00", "00"];
    setState(() {});
  }

  void changeBreakTime(int breakTimeup) {
    breakTime = breakTimeup;
    if (breakTime <= 9) {
      breaktimestr = "0$breakTime";
    } else {
      breaktimestr = breakTime.toString();
    }
    if (pomotime[0] != "00" || pomotime[1] != "00") {
      stop();
    }
    start = 0;
    pomotime = ["00", "00"];
    setState(() {});
  }

  String worktimestr = "25";
  String breaktimestr = "05";
  int score = 0;
  bool isOn = false;
  String work = "Break!";
  List<String> pomotime = ["00", "00"];
  late Timer T;
  bool isBreak = false;
  void increase() {
    work = "Focus Time!";
    isOn = true;
    setState(() {});
    T = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (pomotime[0] == worktimestr && isBreak == false) {
        SystemSound.play(SystemSoundType.alert);
        start = 0;
        pomotime = ["00", "00"];
        work = "Tea Break!";
        isBreak = true;
        setState(() {});
      } else if (pomotime[0] == breaktimestr && isBreak == true) {
        SystemSound.play(SystemSoundType.alert);
        isBreak = false;
        start = 0;
        pomotime = ["00", "00"];
        score++;
        setGreeting();
        work = "Focus Time!";
        setState(() {});
      } else {
        start++;
        pomotime = PomoMethods().timefromSec(start);
        setState(() {});
      }
    });
  }

  void stop() {
    T.cancel();
    isOn = false;
    work = "Tea Break!";
    setState(() {});
  }

  int workTime = 25;
  int breakTime = 5;

  String greeting = "";
  int start = 0;
  var time = int.parse(TimeOfDay.now().toString().substring(10, 12));
  WindowEffect effect = WindowEffect.acrylic;
  void setGreeting() {
    if (time < 12) {
      greeting = "Good Morning";
    } else if (time >= 12 && time <= 17) {
      greeting = "Good Noon";
    } else {
      greeting = "Good Evening";
    }
    setState(() {});
  }

  @override
  void initState() {
    setGreeting();
    Window.setEffect(effect: effect);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    work,
                    style: GoogleFonts.inter(
                      fontSize: 30,
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          darkMode = darkMode ? false : true;
                          Window.setEffect(
                            dark: true,
                            effect: darkMode == false
                                ? WindowEffect.acrylic
                                : WindowEffect.mica,
                          );
                          setState(() {});
                        },
                        child: Icon(
                          darkMode ? Icons.dark_mode : Icons.dark_mode_outlined,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingScreen(
                                        breakTime: breakTime,
                                        workTime: workTime,
                                        changeBreaktime: changeBreakTime,
                                        changeWorktime: changeWorkTime,
                                      )));
                        },
                        child: const Icon(
                          Icons.settings_outlined,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$greeting, Work for $workTime mins and have a tea break for $breakTime mins",
              style: GoogleFonts.inter(),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${pomotime[0]}:${pomotime[1]}",
              style: GoogleFonts.inter(fontSize: 50),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (isOn == true) {
                      stop();
                    } else {
                      increase();
                    }
                  },
                  child: Text(
                    isOn ? "Stop" : "Go",
                    style: GoogleFonts.inter(),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    stop();
                    work = "Break!";
                    start = 0;
                    pomotime = ["00", "00"];
                    setState(() {});
                  },
                  child: Text(
                    "Reset",
                    style: GoogleFonts.inter(),
                  ),
                ),
              ],
            ),
            SizedBox(
                height: 50,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Goals Achieved:",
                              style: GoogleFonts.inter(),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  score.toString(),
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AboutMe()));
                          },
                          child: Text(
                            "About Me!",
                            style: GoogleFonts.inter(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
