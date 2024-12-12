import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:athlete_aware/providers/language_provider.dart';

class CaseStudyScreen extends StatefulWidget {
  @override
  _CaseStudyScreenState createState() => _CaseStudyScreenState();
}

class _CaseStudyScreenState extends State<CaseStudyScreen> {
  final List<Map<String, Map<String, String>>> caseStudies = [
    {
      "en": {
        "title": "SUN YANG (2020)",
        "summary":
            "The most famous case of trimetazidine in sports doping involved Chinese swimmer Sun Yang...",
        "details":
            "The most famous case of trimetazidine in sports doping involved Chinese swimmer Sun Yang. Sun served a three-month ban in 2014 after testing positive for the stimulant. The ruling was not made public by China’s anti-doping agency until after the ban ended, a controversial decision.\n\nThen in 2018, the three-time Olympic champion refused to let anti-doping officials leave his home with a sample of his blood, reportedly ordering someone from his entourage to smash the casing of a blood vial with a hammer so that it would not be valid for testing. He was banned from competing at the Tokyo Olympics, ending his hopes of defending his Olympic title in the 200-meter freestyle.",
        "pollQuestion": "Do you think Sun Yang's actions were justified?",
        "pollOptions": "Yes,No,Not Sure"
      },
      "hi": {
        "title": "सुन यांग (2020)",
        "summary":
            "स्पोर्ट्स डोपिंग में ट्राइमेटाजिडिन का सबसे प्रसिद्ध मामला चीनी तैराक सुन यांग से जुड़ा है...",
        "details":
            "स्पोर्ट्स डोपिंग में ट्राइमेटाजिडिन का सबसे प्रसिद्ध मामला चीनी तैराक सुन यांग से जुड़ा है। सुन ने 2014 में इस उत्तेजक पदार्थ के लिए सकारात्मक परीक्षण के बाद तीन महीने का प्रतिबंध झेला। यह निर्णय चीन की डोपिंग-रोधी एजेंसी द्वारा प्रतिबंध समाप्त होने के बाद सार्वजनिक किया गया, जो विवादास्पद था।\n\n2018 में, तीन बार के ओलंपिक चैंपियन ने डोपिंग अधिकारियों को अपने खून का सैंपल ले जाने से मना कर दिया, reportedly ordering someone from his entourage to smash the casing of a blood vial with a hammer so that it would not be valid for testing. उन्हें टोक्यो ओलंपिक में प्रतिस्पर्धा करने से प्रतिबंधित कर दिया गया था।",
        "pollQuestion": "क्या आपको लगता है कि सुन यांग के कार्य उचित थे?",
        "pollOptions": "हां,नहीं,पक्का नहीं"
      },
    },
    {
      "en": {
        "title": "MARION JONES (2000)",
        "summary":
            "Marion Jones won three gold medals and two bronzes at the Sydney Games...",
        "details":
            "One of the biggest American stars of the Sydney Games, Marion Jones won three gold medals and two bronzes. In 2007, she admitted lying to federal agents about her use of performance-enhancing drugs. She spent six months in jail and the IOC stripped her of all five medals.",
        "pollQuestion":
            "Should athletes lose all their medals for doping violations?",
        "pollOptions": "Yes,No,No Idea"
      },
      "hi": {
        "title": "मेरियन जोन्स (2000)",
        "summary":
            "सिडनी खेलों में मेरियन जोन्स ने तीन स्वर्ण और दो कांस्य पदक जीते...",
        "details":
            "सिडनी खेलों के सबसे बड़े अमेरिकी सितारों में से एक, मेरियन जोन्स ने तीन स्वर्ण और दो कांस्य पदक जीते। 2007 में, उन्होंने प्रदर्शन बढ़ाने वाले ड्रग्स के उपयोग के बारे में संघीय एजेंटों से झूठ बोलने की बात स्वीकार की। उन्होंने छह महीने जेल में बिताए और आईओसी ने उनके सभी पांच पदक छीन लिए।",
        "pollQuestion": "क्या खिलाड़ियों को डोपिंग उल्लंघन के लिए सभी पदक गंवाने चाहिए?",
        "pollOptions": "हां,नहीं,मामले पर निर्भर करता है"
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isHindi = context.watch<LanguageProvider>().isHindi;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          isHindi ? "केस स्टडी" : "Case Studies",
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: caseStudies.length,
        itemBuilder: (context, index) {
          final caseStudy = caseStudies[index][isHindi ? "hi" : "en"]!;
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
    return GestureDetector(
      onTap: () {
        _showCaseStudyDetails(
          caseStudy["title"]!,
          caseStudy["details"]!,
          caseStudy["pollQuestion"]!,
          caseStudy["pollOptions"]!.split(','),
        );
      },
      child: Card(
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
              Text(
                caseStudy["title"]!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                caseStudy["summary"]!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Tap to see more",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCaseStudyDetails(
      String title, String details, String pollQuestion, List<String> options) {
    String? selectedOption;
    bool pollSubmitted = false;
    List<int> percentages = _generateRandomPercentages(options.length);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                Text(
                  pollQuestion,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: options.asMap().entries.map((entry) {
                    int index = entry.key;
                    String option = entry.value;

                    return Column(
                      children: [
                        RadioListTile<String>(
                          title: Row(
                            children: [
                              Text(option),
                              if (pollSubmitted)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    "${percentages[index]}%",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                            ],
                          ),
                          value: option,
                          groupValue: selectedOption,
                          onChanged: pollSubmitted
                              ? null
                              : (value) {
                                  setState(() {
                                    selectedOption = value;
                                    pollSubmitted = true;
                                  });
                                },
                        ),
                        if (pollSubmitted)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: LinearProgressIndicator(
                              value: percentages[index] / 100,
                              backgroundColor: Colors.grey.shade300,
                              color: Colors.blue,
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.watch<LanguageProvider>().isHindi
                  ? "बंद करें"
                  : "Close"),
            ),
          ],
        ),
      ),
    );
  }

  List<int> _generateRandomPercentages(int count) {
    Random random = Random();
    List<int> percentages = List.generate(count, (_) => random.nextInt(100));
    int total = percentages.reduce((a, b) => a + b);
    return percentages.map((p) => (p / total * 100).round()).toList();
  }
}
