import 'package:flutter/material.dart';

class CaseStudyScreen extends StatefulWidget {
  @override
  _CaseStudyScreenState createState() => _CaseStudyScreenState();
}

class _CaseStudyScreenState extends State<CaseStudyScreen> {
  final List<Map<String, String>> caseStudies = [
    {
      "title": "SUN YANG (2020)",
      "summary":
          "The most famous case of trimetazidine in sports doping involved Chinese swimmer Sun Yang...",
      "details":
          "The most famous case of trimetazidine in sports doping involved Chinese swimmer Sun Yang. Sun served a three-month ban in 2014 after testing positive for the stimulant. The ruling was not made public by China’s anti-doping agency until after the ban ended, a controversial decision.\n\nThen in 2018, the three-time Olympic champion refused to let anti-doping officials leave his home with a sample of his blood, reportedly ordering someone from his entourage to smash the casing of a blood vial with a hammer so that it would not be valid for testing. He was banned from competing at the Tokyo Olympics, ending his hopes of defending his Olympic title in the 200-meter freestyle."
    },
    {
      "title": "NADEZHDA SERGEEVA (2018)",
      "summary":
          "The Russian bobsledder was disqualified from the 2018 Pyeongchang Olympics...",
      "details":
          "The Russian bobsledder was disqualified from the 2018 Pyeongchang Olympics after testing positive for the banned substance trimetazidine.\n\nAt the time, the head of Russia’s Federal Medical-Biological Agency, said his agency tried to bar Sergeeva from competing because of a heart condition, but Sports Ministry officials let her travel. Vladimir Uiba said “organizational fecklessness” led to Sergeeva’s mother, a doctor, giving her unapproved medicine containing trimetazidine.\n\nShe served an eight-month ban."
    },
    {
      "title": "BEN JOHNSON (1988)",
      "summary":
          "Probably the most infamous drug scandal in Olympic history involved Canadian sprinter Ben Johnson...",
      "details":
          "Probably the most infamous drug scandal in Olympic history involved Canadian sprinter Ben Johnson, marring one of the signature events of the Summer Games — the 100-meter dash. Johnson appeared to have won the race at the Seoul Games in world record time, but he tested positive for an anabolic steroid and had his gold medal taken away. It went to American rival Carl Lewis instead.\n\nJuan Antonio Samaranch, the president of the International Olympic Committee at the time, said that penalties against Johnson and others were an indication that 'we have won the battle against doping.'"
    },
    // Add more case studies as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Case Studies", style: const TextStyle(color: Colors.black)),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: caseStudies.length,
        itemBuilder: (context, index) {
          final caseStudy = caseStudies[index];
          return _buildCaseStudyCard(caseStudy, index);
        },
      ),
    );
  }

  Widget _buildCaseStudyCard(Map<String, String> caseStudy, int index) {
    final colors = [
      Colors.green.shade200,
      Colors.red.shade200,
      Colors.yellow.shade200,
      Colors.blue.shade200,
      Colors.pink.shade200,
      Colors.orange.shade200,
    ];
    return Card(
      color: colors[index % colors.length],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              caseStudy["title"]!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            // Summary
            Text(
              caseStudy["summary"]!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            // See More Button
            GestureDetector(
              onTap: () {
                _showCaseStudyDetails(caseStudy["title"]!, caseStudy["details"]!);
              },
              child: const Text(
                "See More",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCaseStudyDetails(String title, String details) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Text(
            details,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
