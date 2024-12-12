import 'dart:async';
import 'dart:convert';
import 'package:athlete_aware/screens/quizes/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class QuizLevelScreen extends StatefulWidget {
  const QuizLevelScreen({Key? key}) : super(key: key);

  @override
  State<QuizLevelScreen> createState() => _QuizLevelScreenState();
}

class _QuizLevelScreenState extends State<QuizLevelScreen> {
  String selectedLevel = "Easy"; // Default level
  final List<Map<String, dynamic>> quizLevels = [
    {"name": "Easy", "color": Colors.green},
    {"name": "Medium", "color": Colors.yellow},
    {"name": "Difficult", "color": Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D1B5A), // Purple background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Custom image at the top
            const CircleAvatar(
              radius: 100,
              backgroundImage:
                  AssetImage("assets/smiley.png"), // Replace with your image
            ),
            const SizedBox(height: 30),

            // Title and description
            Text(
              "Ready for a QuikQuiz?",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              "Gear up for a QuikQuiz sprint! You've got just 30 seconds per question. Tap the info icon at the top right to check out the module each question comes from. Let's see what you've got! - Goodluck!",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Dropdown for selecting level
            // Dropdown for selecting level
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Softer shadow
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedLevel,
                  isExpanded: true,
                  icon:
                      const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  dropdownColor: Colors.white, // Background color for dropdown
                  items: quizLevels.map((level) {
                    return DropdownMenuItem<String>(
                      value: level["name"],
                      child: Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: level["color"], // Circle color
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            level["name"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87, // Text color
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLevel = newValue!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(
              height: 80,
            ),

            // Start quiz button
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ),
                  );
                  // Handle start quiz functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C4DFF), // Purple button
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.edit, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      "Start A New Quiz",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
