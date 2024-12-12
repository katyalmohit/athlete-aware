import 'dart:async';
import 'dart:convert';
import 'package:athlete_aware/screens/courses/completed.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List responseData = [];
  int number = 0;
  late Timer _timer;
  int _secondRemaining = 15;
  List<String> shuffledOptions = [];
  String? selectedOption; // Track selected option
  int score = 0; // Track sco
  Map<String, Color> optionColors = {}; // Track colors for options


  Future api() async {
    final response =
        await http.get(Uri.parse('https://opentdb.com/api.php?amount=10'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'];
      setState(() {
        responseData = data;
        updateShuffleOption();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    api();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B2F), // Dark background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Timer and Question Section
// Timer and Question Section
            SizedBox(
              height: 350,
              width: double.infinity,
              child: Stack(
                children: [
                  // Purple Container
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8A2BE2), Color(0xFF6A0DAD)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  // Question Card
                  Positioned(
                    bottom: 40, // Adjusted spacing
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Question Progress and Timer
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '05',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '07',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8), // Reduced spacing
                          // Question Number
                          Text(
                            "Question ${number + 1}/10",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: const Color(0xFF8A2BE2),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8), // Reduced spacing
                          // Question Text
                          Text(
                            responseData.isNotEmpty
                                ? responseData[number]['question']
                                : '',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Timer Circle
                  Positioned(
                    bottom: 240, // Adjusted spacing
                    left: MediaQuery.of(context).size.width / 2 - 42,
                    child: CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Text(
                          _secondRemaining.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 24, // Reduced font size
                            color: const Color(0xFF8A2BE2),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10), // Reduced spacing

            // Options Section
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: (responseData.isNotEmpty &&
                          responseData[number]['incorrect_answers'] != null)
                      ? shuffledOptions.map((option) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: GestureDetector(
      onTap: () {
        setState(() {
          if (selectedOption == null) {
            selectedOption = option;
            if (option == responseData[number]['correct_answer']) {
              optionColors[option] = Colors.green; // Correct answer
              score++;
            } else {
              optionColors[option] = Colors.red; // Incorrect answer
              optionColors[responseData[number]['correct_answer']] = Colors.green; // Highlight correct answer
            }
            // Delay before proceeding to the next question
            Future.delayed(const Duration(seconds: 2), () {
              nextQuestion();
            });
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500), // Animation duration
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: optionColors[option] ?? Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: optionColors[option] ?? const Color(0xFF8A2BE2),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                option,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: optionColors[option] != null
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ),
            Icon(
              optionColors[option] == Colors.green
                  ? Icons.check_circle
                  : optionColors[option] == Colors.red
                      ? Icons.cancel
                      : Icons.radio_button_off,
              color: optionColors[option] ?? const Color(0xFF8A2BE2),
            ),
          ],
        ),
      ),
    ),
  );
}).toList()

                      : [],
                ),
              ),
            ),
            // const SizedBox(height: 3),

            // Next Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(191, 194, 232, 26),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              onPressed: () {
                checkAnswer();
              },
              child: Text(
                'Next',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkAnswer() {
    if (selectedOption == responseData[number]['correct_answer']) {
      score++;
    }
    if (number == 9) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Completed(score: score),
        ),
      );
    } else {
      nextQuestion();
    }
  }
  
void nextQuestion() {
  if (number < responseData.length - 1) {
    // Proceed to the next question if available
    setState(() {
      number++;
      selectedOption = null;
      _secondRemaining = 15;
      optionColors.clear(); // Reset colors for the next question
      updateShuffleOption();
    });
  } else {
    // Navigate to the completion screen if no more questions
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Completed(score: score),
      ),
    );
  }
}



void startTimer() {
  Timer.periodic(const Duration(seconds: 1), (timer) {
    setState(() {
      if (_secondRemaining > 0) {
        _secondRemaining--;
      } else {
        // Check if quiz is complete
        if (number < responseData.length - 1) {
          nextQuestion();
        } else {
          timer.cancel(); // Stop the timer
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Completed(score: score),
            ),
          );
        }
      }
    });
  });
}


  void updateShuffleOption() {
    setState(() {
      shuffledOptions = shuffleOption([
        responseData[number]['correct_answer'],
        ...(responseData[number]['incorrect_answers'] as List)
      ]);
    });
  }

  List<String> shuffleOption(List<String> option) {
    List<String> shuffledOptions = List.from(option);
    shuffledOptions.shuffle();
    return shuffledOptions;
  }

}