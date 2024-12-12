import 'package:athlete_aware/screens/courses/chapter.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(300), // Total height for AppBar and green box
        child: AppBar(
          automaticallyImplyLeading: false, // To fully customize the AppBar
          elevation: 0,
          backgroundColor: Colors.green.shade100,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Module:",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "01",
                            style: TextStyle(
                              color: Colors.green.shade900, // Dark Green
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Athlete Testing",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Divider(color: Colors.black),
                      const Text(
                        "Meet Karan, a young athlete with national dreams. Join his journey to learn fair play and the anti-doping process, from sample collection to understanding his rights.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MiddleSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class MiddleSection extends StatefulWidget {
  @override
  _MiddleSectionState createState() => _MiddleSectionState();
}

class _MiddleSectionState extends State<MiddleSection> {
  bool isExpanded = true; // Default state is expanded
  int selectedChapter = -1; // Tracks the selected chapter for showing the explore button

  final List<String> chapterNames = [
    "Introduction & Sample Collection",
    "In-Competition Testing",
    "Out-of-Competition Testing",
    "Athlete Rights & Responsibilities",
    "Registered Testing Pool (RTP)",
    "ADAMS & Whereabouts"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading:
                    const Icon(Icons.circle, size: 16, color: Colors.green),
                title: const Text(
                  "Chapters",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Updated to black
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ),

              if (isExpanded) ...[
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Text(
                      "Progress:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "19%",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Center(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // Explore button functionality
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.blue.shade100,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //     ),
                //     child: const Text(
                //       "Explore",
                //       style: TextStyle(
                //         color: Colors.blue,
                //         fontSize: 14,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 16),
                const Divider(color: Colors.grey),

                ...List.generate(chapterNames.length, (index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: RichText(
                      text: TextSpan(
                        text: "${index + 1}. ",
                        style: const TextStyle(
                          fontSize: 18, // Larger font size
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Black for chapter number
                        ),
                        children: [
                          TextSpan(
                            text: chapterNames[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey, // Greyish color for chapter text
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedChapter = index; // Highlight the selected chapter
                      });
                    },
                    trailing: selectedChapter == index
                        ? ElevatedButton(
                            onPressed: () {
                              if (index == 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChapterScreen()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Explore",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                  );
                }),
                const SizedBox(height: 16),

                const Divider(color: Colors.grey),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading:
                      const Icon(Icons.circle, size: 16, color: Colors.green),
                  title: const Text(
                    "Certificate",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Certification exam gets unlocked only on meeting the following criteria",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 24, top: 8),
                      child: Text(
                        "Instructions",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle download certificate functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Download Certificate",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}