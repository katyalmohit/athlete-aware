import 'package:flutter/material.dart';

class ProhibitedScreen extends StatelessWidget {
  final List<Map<String, dynamic>> prohibitedItems = [
    {
      "title": "Stimulants",
      "description": "Substances that increase alertness, attention, and energy.",
      "examples": ["Amphetamines", "Cocaine", "Methamphetamine"],
      "icon": Icons.bolt,
      "iconColor": Colors.orange,
    },
    {
      "title": "Anabolic Agents",
      "description": "Promote the growth of skeletal muscle and lean body mass.",
      "examples": ["Nandrolone", "Stanozolol", "Testosterone"],
      "icon": Icons.fitness_center,
      "iconColor": Colors.blue,
    },
    {
      "title": "Diuretics and Masking Agents",
      "description": "Help eliminate fluids, potentially hiding other substances.",
      "examples": ["Furosemide", "Hydrochlorothiazide"],
      "icon": Icons.water_drop,
      "iconColor": Colors.teal,
    },
    {
      "title": "Peptide Hormones",
      "description": "Stimulate production of natural growth factors.",
      "examples": ["Erythropoietin (EPO)", "Growth Hormone (hGH)"],
      "icon": Icons.healing,
      "iconColor": Colors.purple,
    },
    {
      "title": "Beta-2 Agonists",
      "description": "Used for asthma treatment, but can enhance performance.",
      "examples": ["Salbutamol", "Clenbuterol"],
      "icon": Icons.air,
      "iconColor": Colors.lightBlue,
    },
    {
      "title": "Manipulation of Blood",
      "description": "Techniques like blood doping to enhance oxygen delivery.",
      "examples": ["Blood transfusions", "Artificial oxygen carriers"],
      "icon": Icons.bloodtype,
      "iconColor": Colors.red,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prohibited Substances & Methods',
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
          itemCount: prohibitedItems.length,
          itemBuilder: (context, index) {
            final item = prohibitedItems[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ExpansionTile(
                leading: Icon(
                  item["icon"],
                  color: item["iconColor"],
                  size: 30,
                ),
                title: Text(
                  item["title"],
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
                          item["description"],
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Examples:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...item["examples"].map((example) => Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    example,
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
