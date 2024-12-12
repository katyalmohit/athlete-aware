import 'package:flutter/material.dart';

class TestingDetectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> testingMethods = [
    {
      "title": "Urine Testing",
      "description":
          "The most common method for detecting prohibited substances. Urine samples are analyzed for traces of banned drugs and metabolites.",
      "icon": Icons.opacity,
      "advantages": [
        "Non-invasive collection",
        "Effective for a wide range of substances",
        "Cost-effective"
      ]
    },
    {
      "title": "Blood Testing",
      "description":
          "Detects substances and methods such as blood doping, EPO, and anabolic agents that affect the bloodstream.",
      "icon": Icons.bloodtype,
      "advantages": [
        "Can detect recent usage",
        "Effective for growth hormones and EPO",
        "Provides comprehensive data"
      ]
    },
    {
      "title": "Biological Passport",
      "description":
          "Tracks an athlete's biological variables over time to detect abnormalities that suggest doping.",
      "icon": Icons.paste,
      "advantages": [
        "Long-term monitoring",
        "Effective for identifying blood doping",
        "Non-reliant on single sample tests"
      ]
    },
    {
      "title": "Hair Testing",
      "description":
          "Analyzes hair samples to detect long-term substance usage, providing a history of drug intake.",
      "icon": Icons.content_cut,
      "advantages": [
        "Non-invasive",
        "Can detect long-term usage",
        "Stable sample storage"
      ]
    },
    {
      "title": "Saliva Testing",
      "description":
          "Detects recent usage of certain substances by analyzing saliva samples.",
      "icon": Icons.masks,
      "advantages": [
        "Quick and easy collection",
        "Non-invasive",
        "Effective for certain stimulants"
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Testing & Detection Methods',
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
          itemCount: testingMethods.length,
          itemBuilder: (context, index) {
            final method = testingMethods[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ExpansionTile(
                leading: Icon(
                  method["icon"],
                  color: Colors.blueAccent,
                  size: 30,
                ),
                title: Text(
                  method["title"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          method["description"],
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Advantages:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...method["advantages"].map((advantage) => Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    advantage,
                                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
