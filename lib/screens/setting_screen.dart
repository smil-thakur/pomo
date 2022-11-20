import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomo/screens/home_screen.dart';

class SettingScreen extends StatefulWidget {
  final Function(int workTime) changeWorktime;
  final Function(int workTime) changeBreaktime;
  final int workTime;
  final int breakTime;
  const SettingScreen(
      {super.key,
      required this.changeWorktime,
      required this.changeBreaktime,
      required this.breakTime,
      required this.workTime});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  changeTheme() async {
    await Window.setEffect(
      dark: true,
      effect: darkMode == false ? WindowEffect.acrylic : WindowEffect.mica,
    );
  }

  int workTimehere = 0;
  int breakTimehere = 0;
  @override
  void initState() {
    workTimehere = widget.workTime;
    breakTimehere = widget.breakTime;
    changeTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Change your Work Mins",
              style: GoogleFonts.inter(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (workTimehere > 5) {
                          workTimehere = workTimehere - 5;
                          widget.changeWorktime(workTimehere);
                        }
                        setState(() {});
                      },
                      child: Text(
                        "-",
                        style: GoogleFonts.inter(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        workTimehere.toString(),
                        style: GoogleFonts.inter(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (workTimehere <= 50) {
                          workTimehere = workTimehere + 5;
                          widget.changeWorktime(workTimehere);
                        }
                        setState(() {});
                      },
                      child: Text(
                        "+",
                        style: GoogleFonts.inter(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              "Change your Tea Break Mins",
              style: GoogleFonts.inter(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (breakTimehere > 5) {
                          breakTimehere = breakTimehere - 5;
                          widget.changeBreaktime(breakTimehere);
                        }
                        setState(() {});
                      },
                      child: Text(
                        "-",
                        style: GoogleFonts.inter(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        breakTimehere.toString(),
                        style: GoogleFonts.inter(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (breakTimehere <= 50) {
                          breakTimehere = breakTimehere + 5;
                          widget.changeBreaktime(breakTimehere);
                        }
                        setState(() {});
                      },
                      child: Text(
                        "+",
                        style: GoogleFonts.inter(),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
