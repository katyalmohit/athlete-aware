import 'package:athlete_aware/screens/home_screen.dart';
import 'package:athlete_aware/screens/quizes/quiz_selection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Completed extends StatelessWidget {
  final int score;

  const Completed({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B2F), // Dark background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular Score Display
            SizedBox(
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: const Color(0xFF8A2BE2),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Your Score",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "$score/10",
                              style: const TextStyle(
                                fontSize: 36,
                                color: Color(0xFF8A2BE2),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Quiz Summary Heading
            Text(
              "Quiz Summary",
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Stats Display Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCircle(
                    value: "$score",
                    label: "Correct",
                    color: Colors.green,
                  ),
                  _buildStatCircle(
                    value: "10",
                    label: "Total",
                    color: Colors.blue,
                  ),
                  _buildStatCircle(
                    value: "${10 - score}",
                    label: "Wrong",
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Buttons Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Play Again
                _buildActionButton(
                  context,
                  label: "Play Again",
                  icon: Icons.refresh,
                  color: const Color(0xFF8A2BE2),
                  onPressed: () {
                    Navigator.pop(context);
                    
                  },
                ),
                // Home
                _buildActionButton(
                  context,
                  label: "Home",
                  icon: Icons.home,
                  color: const Color(0xFF6A0DAD),
                  onPressed: () {
Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AntiDopingScreen(),
                      ),
                    );                  },
                ),
                // Leaderboard
                _buildActionButton(
                  context,
                  label: "Leaderboard",
                  icon: Icons.leaderboard,
                  color: const Color(0xFF6A0DAD),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizLevelScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCircle(
      {required String value, required String label, required Color color}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: color.withOpacity(0.5),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 22,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context,
      {required String label,
      required IconData icon,
      required Color color,
      required VoidCallback onPressed}) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed, // Use only the passed callback
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}