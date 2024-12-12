import 'package:athlete_aware/screens/athlete_responsibilities.dart';
import 'package:athlete_aware/screens/case_study_screen.dart';
import 'package:athlete_aware/screens/clean_sport_advocacy.dart';
import 'package:athlete_aware/screens/courses/course.dart';
import 'package:athlete_aware/screens/doping_consequences.dart';
import 'package:athlete_aware/screens/mythVsFactsScreen.dart';
import 'package:athlete_aware/screens/prohibited_screen.dart';
import 'package:athlete_aware/screens/signin_screen.dart';
import 'package:athlete_aware/screens/signup_screen.dart';
import 'package:athlete_aware/screens/testing_detection_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:athlete_aware/providers/language_provider.dart';

class AntiDopingScreen extends StatefulWidget {
  @override
  _AntiDopingScreenState createState() => _AntiDopingScreenState();
}

class _AntiDopingScreenState extends State<AntiDopingScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, String>> allSections = [];
  List<Map<String, String>> filteredSections = [];

  @override
  void initState() {
    super.initState();
    initializeSections();
  }

  void initializeSections() {
    final isHindi = context.read<LanguageProvider>().isHindi;
    allSections = isHindi
        ? [
            {"title": "एंटी-डोपिंग जागरूकता", "number": "01"},
            {"title": "प्रतिबंधित पदार्थ और तरीके", "number": "02"},
            {"title": "परीक्षण और पहचान", "number": "03"},
            {"title": "एथलीट की जिम्मेदारियां", "number": "04"},
            {"title": "डोपिंग के परिणाम", "number": "05"},
            {"title": "स्वच्छ खेल प्रचार", "number": "06"},
            {"title": "अध्ययन मामला", "number": "07"},
            {"title": "मिथक बनाम तथ्य", "number": "08"},
          ]
        : [
            {"title": "Anti-Doping Awareness", "number": "01"},
            {"title": "Prohibited Substances & Methods", "number": "02"},
            {"title": "Testing & Detection", "number": "03"},
            {"title": "Athlete Responsibilities", "number": "04"},
            {"title": "Consequences of Doping", "number": "05"},
            {"title": "Clean Sport Advocacy", "number": "06"},
            {"title": "Case Study", "number": "07"},
            {"title": "Myths vs Facts", "number": "08"},
          ];
    filteredSections = allSections;
  }

  void filterSections(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredSections = allSections;
      } else {
        filteredSections = allSections
            .where((section) => section["title"]!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isHindi = context.watch<LanguageProvider>().isHindi;
    initializeSections();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onSelected: (value) {
              if (value == 'Sign In') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              } else if (value == 'Sign Up') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
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
              context.read<LanguageProvider>().toggleLanguage();
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: isHindi ? "खोजें..." : "Search...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  filterSections(value);
                },
              ),
            ),

            Text(
              isHindi ? "नमस्ते उपभोक्ता!" : "Hello User!",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: const BorderSide(color: Colors.blueAccent, width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 120,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/online-course.png'),
                        
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                ? "स्वच्छ खेल की अनिवार्यता जानें।"
                                : "Learn the essentials of clean sport.",
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
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isHindi ? "कोर्स ट्रैक करें" : "Track Courses",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Icon(Icons.track_changes, color: Colors.green),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isHindi
                          ? "एंटी-डोपिंग जागरूकता - 75% पूरा"
                          : "Anti-Doping Awareness - 75% Completed",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: 0.75,
                        backgroundColor: Colors.grey[300],
                        color: Colors.green,
                        minHeight: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

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
              itemCount: filteredSections.length,
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
                final section = filteredSections[index];
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
                    if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProhibitedScreen(),
                        ),
                      );
                    }
                    if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestingDetectionScreen(),
                        ),
                      );
                    }
                    if (index == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AthleteResponsibilitiesScreen(),
                        ),
                      );
                    }
                     if (index == 4) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DopingConsequencesScreen(),
                        ),
                      );
                    }
                    if (index == 5) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CleanSportAdvocacyScreen(),
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
                              color: colors[index % colors.length],
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
                                  section["number"]!,
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
                                  section["title"]!,
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
}