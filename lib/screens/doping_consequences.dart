import 'package:flutter/material.dart';

class DopingConsequencesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> consequences = [
    {
      "title": "Health Risks",
      "description":
          "Doping can lead to severe health problems, including heart disease, liver damage, and hormonal imbalances.",
      "icon": Icons.health_and_safety,
    },
    {
      "title": "Suspension",
      "description":
          "Athletes caught doping face temporary or permanent suspension from competitions.",
      "icon": Icons.timer_off,
    },
    {
      "title": "Reputation Damage",
      "description":
          "Doping scandals can ruin an athlete's career and public image.",
      "icon": Icons.person_off,
    },
    {
      "title": "Loss of Medals",
      "description":
          "Athletes found guilty of doping may lose medals, titles, and records.",
      "icon": Icons.military_tech,
    },
    {
      "title": "Legal Consequences",
      "description":
          "Doping can lead to legal actions, including fines and criminal charges.",
      "icon": Icons.gavel,
    },
    {
      "title": "Impact on Team",
      "description":
          "Doping can disqualify teams and harm the collective reputation of teammates and organizations.",
      "icon": Icons.group_off,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doping Consequences',
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
          itemCount: consequences.length,
          itemBuilder: (context, index) {
            final consequence = consequences[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                leading: Icon(
                  consequence["icon"],
                  color: Colors.redAccent,
                  size: 30,
                ),
                title: Text(
                  consequence["title"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  consequence["description"],
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