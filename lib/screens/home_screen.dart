import 'package:athlete_aware/screens/case_study_screen.dart';
import 'package:athlete_aware/screens/courses/course.dart';
import 'package:athlete_aware/screens/mythVsFactsScreen.dart';
import 'package:athlete_aware/screens/signin_screen.dart';
import 'package:athlete_aware/screens/signup_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:athlete_aware/providers/language_provider.dart';

class AntiDopingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isHindi = context.watch<LanguageProvider>().isHindi; // Global language state

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        actions: [
          // Profile Icon with Dropdown
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onSelected: (value) {
              if (value == 'Sign In') {
                // Navigate to Sign In screen
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
                      );
              } else if (value == 'Sign Up') {
                // Navigate to Sign Up screen
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'Sign In',
                child: Text('Sign In'),
              ),
              const PopupMenuItem(
                value: 'Sign Up',
                child: Text('Sign Up'),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              context.read<LanguageProvider>().toggleLanguage(); // Toggle language
            },
            icon: Icon(
              isHindi ? Icons.language : Icons.translate,
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
              isHindi ? "नमस्ते श्वेता!" : "Hello Shweta!",
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
                    // Image Placeholder
                    Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(width: 12),
                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            isHindi
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
                            isHindi
                                ? "हमारे शुरुआती-अनुकूल वीडियो श्रृंखला के साथ स्वच्छ खेल की अनिवार्यता जानें।"
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
                              isHindi ? "अन्वेषण करें" : "Explore",
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
              isHindi ? "सीखना जारी रखें" : "Continue Learning",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            // Modules List
            _buildModuleCard(1, isHindi ? "एंटी-डोपिंग का परिचय" : "Introduction to Anti-Doping"),
            const SizedBox(height: 8),
            _buildModuleCard(2, isHindi ? "प्रतिबंधित पदार्थ और तरीके" : "Prohibited Substances & Methods"),

            const SizedBox(height: 16),

            // Quiz Section
            Text(
              isHindi ? "Modules" : "Modules",
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
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                final colors = [
                  Colors.green.shade200,
                  Colors.red.shade200,
                  Colors.yellow.shade200,
                  const Color.fromARGB(255, 178, 130, 255),
                  Colors.blue.shade200,
                  Colors.pink.shade200,
                  Colors.orange.shade200,
                  Colors.purple.shade200,
                ];
                final titles = isHindi
                    ? [
                        "एंटी-डोपिंग जागरूकता",
                        "प्रतिबंधित पदार्थ और तरीके",
                        "परीक्षण और पहचान",
                        "एथलीट की जिम्मेदारियां",
                        "डोपिंग के परिणाम",
                        "स्वच्छ खेल प्रचार",
                        "अध्ययन मामला",
                        "मिथक बनाम तथ्य",
                      ]
                    : [
                        "Anti-doping Awareness",
                        "Prohibited Substances & Methods",
                        "Testing & Detection",
                        "Athlete Responsibilities",
                        "Consequences of Doping",
                        "Clean Sport Advocacy",
                        "Case Study",
                        "Myths vs Facts",
                      ];
                final numbers = ["01", "02", "03", "04", "05", "06", "07", "08"];

                return GestureDetector(
                  onTap: () {
                     if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseScreen(),
                        ),
                      );
                    }
                    if (index == 6) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CaseStudyScreen(),
                        ),
                      );
                    }
                    if (index == 7) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MythVsFactsScreen(),
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
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: AutoSizeText(
                                  titles[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  minFontSize: 12,
                                  overflow: TextOverflow.ellipsis,
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
              "Module: $moduleNumber",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
