import 'package:flutter/material.dart';

class AthleteResponsibilitiesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> responsibilities = [
    {
      "title": "Stay Informed",
      "description":
          "Athletes must stay updated on the latest anti-doping regulations and prohibited substance lists.",
      "icon": Icons.info_outline,
    },
    {
      "title": "Avoid Prohibited Substances",
      "description":
          "Athletes are responsible for ensuring that no prohibited substances enter their body.",
      "icon": Icons.no_drinks,
    },
    {
      "title": "Submit to Testing",
      "description":
          "Athletes must comply with sample collection procedures whenever required.",
      "icon": Icons.hot_tub_rounded,
    },
    {
      "title": "Maintain Accurate Whereabouts",
      "description":
          "Provide accurate and up-to-date information about your location for testing purposes.",
      "icon": Icons.location_on,
    },
    {
      "title": "Be A Role Model",
      "description":
          "Promote clean sport by setting an example of integrity and honesty.",
      "icon": Icons.star,
    },
    {
      "title": "Declare Medications",
      "description":
          "Inform medical professionals of your obligations and declare any medications during testing.",
      "icon": Icons.medical_services,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Athlete Responsibilities',
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
          itemCount: responsibilities.length,
          itemBuilder: (context, index) {
            final responsibility = responsibilities[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                leading: Icon(
                  responsibility["icon"],
                  color: Colors.blueAccent,
                  size: 30,
                ),
                title: Text(
                  responsibility["title"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  responsibility["description"],
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
