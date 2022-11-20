import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

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
          children: [
            Text(
              "Hello, My name is Smil",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "I love to build Flutter Apps",
              style: GoogleFonts.inter(),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Check out my linkedIn and Github",
              style: GoogleFonts.inter(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        launchUrlString("https://github.com/smil-thakur");
                      },
                      child: Text(
                        "Github",
                        style: GoogleFonts.inter(),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        launchUrlString(
                            "https://www.linkedin.com/in/smil-raj-thakur-b499471bb/");
                      },
                      child: Text(
                        "LinkedIn",
                        style: GoogleFonts.inter(),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
