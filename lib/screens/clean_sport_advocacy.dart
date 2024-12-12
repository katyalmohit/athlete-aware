import 'package:flutter/material.dart';

class CleanSportAdvocacyScreen extends StatelessWidget {
  final List<Map<String, dynamic>> advocacyPoints = [
    {
      "title": "Promote Integrity",
      "description":
          "Encourage honesty and integrity in sports to ensure fair competition.",
      "icon": Icons.handshake,
    },
    {
      "title": "Educate Athletes",
      "description":
          "Spread awareness about the dangers of doping and the importance of clean sport.",
      "icon": Icons.school,
    },
    {
      "title": "Support Testing Programs",
      "description":
          "Advocate for robust testing programs to maintain transparency and fairness.",
      "icon": Icons.science,
    },
    {
      "title": "Community Engagement",
      "description":
          "Involve communities in promoting clean sport through events and discussions.",
      "icon": Icons.group,
    },
    {
      "title": "Highlight Role Models",
      "description":
          "Showcase athletes who exemplify clean sport practices as role models.",
      "icon": Icons.star,
    },
    {
      "title": "Collaborate Globally",
      "description":
          "Work with international organizations to promote clean sport on a global scale.",
      "icon": Icons.public,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clean Sport Advocacy',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: advocacyPoints.length,
          itemBuilder: (context, index) {
            final point = advocacyPoints[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                leading: Icon(
                  point["icon"],
                  color: Colors.green,
                  size: 30,
                ),
                title: Text(
                  point["title"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  point["description"],
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
