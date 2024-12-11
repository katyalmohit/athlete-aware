import 'package:athlete_aware/screens/case_study_screen.dart';
import 'package:flutter/material.dart';

class AntiDopingScreen extends StatefulWidget {
  @override
  _AntiDopingScreenState createState() => _AntiDopingScreenState();
}

class _AntiDopingScreenState extends State<AntiDopingScreen> {
  bool _isHindi = false; // Track language toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isHindi = !_isHindi; // Toggle the language
              });
            },
            icon: Icon(
              _isHindi ? Icons.language : Icons.translate,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Header
            Text(
              _isHindi ? "नमस्ते श्वेता!" : "Hello Shweta!",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Introducing Card
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(color: Colors.blueAccent, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[300], // Placeholder for the image
                    ),
                    const SizedBox(width: 12),
                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Introducing Label
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "Introducing",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isHindi
                                ? "एंटी-डोपिंग वीडियो श्रृंखला"
                                : "Anti-Doping Video Series",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _isHindi
                                ? "हमारे शुरुआती-अनुकूल वीडियो श्रृंखला के साथ स्वच्छ खेल के अनिवार्यताएं जानें।"
                                : "Learn the essentials of clean sport with our beginner-friendly video series.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              _isHindi ? "अन्वेषण करें" : "Explore",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Start Learning Section
            Text(
              _isHindi ? "शिक्षा शुरू करें" : "Start Learning",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            // Modules List
            _buildModuleCard(1,
                _isHindi ? "एंटी-डोपिंग का परिचय" : "Introduction to Anti-Doping"),
            const SizedBox(height: 8),
            _buildModuleCard(2,
                _isHindi ? "एंटी-डोपिंग का परिचय" : "Introduction to Anti-Doping"),

            const SizedBox(height: 16),

            // Quiz Section
            Text(
              _isHindi ? "प्रश्नोत्तरी" : "Quiz",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 cards per row
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: 7, // Number of quiz cards
              itemBuilder: (context, index) {
                // Data for each card
                final colors = [
                  Colors.green.shade200,
                  Colors.red.shade200,
                  Colors.yellow.shade200,
                  Colors.green.shade200,
                  Colors.blue.shade200,
                  Colors.pink.shade200,
                  Colors.orange.shade200,
                ];
                final titles = _isHindi
                    ? [
                        "एंटी-डोपिंग जागरूकता",
                        "प्रतिबंधित पदार्थ और तरीके",
                        "परीक्षण और पहचान",
                        "एथलीट की जिम्मेदारियां",
                        "डोपिंग के परिणाम",
                        "स्वच्छ खेल प्रचार",
                        "अध्ययन मामला",
                      ]
                    : [
                        "Anti-doping Awareness",
                        "Prohibited substances & Methods",
                        "Testing & Detection",
                        "Athlete Responsibilities",
                        "Consequences of Doping",
                        "Clean Sport Advocacy",
                        "Case Study",
                      ];
                final numbers = ["01", "02", "03", "04", "05", "06", "07"];

                return GestureDetector(
                  onTap: () {
                    if (index == 6) {
                      // Navigate to Case Study screen for the last card
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CaseStudyScreen(),
                        ),
                      );
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Column(
                      children: [
                        // Top Section (Colored Rectangle)
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: colors[index],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  numbers[index],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Bottom Section (Content Area)
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white, // Set the background color to white
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  titles[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard(int moduleNumber, String title) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isHindi ? "मॉड्यूल:" : "Module:",
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 52, 52, 52),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "$moduleNumber | $title",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _isHindi ? "स्तर: प्रारंभिक" : "Level: Beginner",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  _isHindi ? "अध्याय: 01" : "Chapter: 01",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
