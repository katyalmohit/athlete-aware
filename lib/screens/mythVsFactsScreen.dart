import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class MythVsFactsScreen extends StatelessWidget {
  final List<Map<String, Map<String, String>>> mythsAndFacts = [
    {
      "myth": {
        "en": "Anti-doping only applies to elite and professional sportspersons.",
        "hi": "एंटी-डोपिंग केवल शीर्ष और पेशेवर खिलाड़ियों पर लागू होता है।"
      },
      "fact": {
        "en": "The anti-doping rules apply to all levels of sports, spanning professional golf, elite amateur golf, club competition golf, and even non-competitive social golf.",
        "hi": "एंटी-डोपिंग नियम सभी स्तरों के खेलों पर लागू होते हैं, जिसमें पेशेवर गोल्फ, शीर्ष शौकिया गोल्फ, क्लब प्रतियोगिता गोल्फ और यहां तक कि गैर-प्रतिस्पर्धात्मक सामाजिक गोल्फ शामिल हैं।"
      },
    },
    {
      "myth": {
        "en": "It’s not a problem if you accidentally take a banned substance.",
        "hi": "यदि आप गलती से प्रतिबंधित पदार्थ ले लेते हैं, तो यह समस्या नहीं है।"
      },
      "fact": {
        "en": "It is against the rules to have a prohibited substance in your system, regardless of whether or not you meant to take the substance or enhance your performance.",
        "hi": "चाहे आप इसे जानबूझकर लें या प्रदर्शन बढ़ाने के लिए लें, आपके शरीर में प्रतिबंधित पदार्थ होना नियमों के खिलाफ है।"
      },
    },
    {
      "myth": {
        "en": "Drugs that aren’t performance-enhancing aren’t banned.",
        "hi": "जो दवाएं प्रदर्शन को नहीं बढ़ातीं, वे प्रतिबंधित नहीं हैं।"
      },
      "fact": {
        "en": "Substances which don’t directly enhance golfing performance can, and frequently are, still prohibited. Many medications for common conditions such as Asthma are included on the Prohibited List.",
        "hi": "ऐसे पदार्थ जो सीधे गोल्फ प्रदर्शन को नहीं बढ़ाते, वे अभी भी प्रतिबंधित हो सकते हैं। सामान्य स्थितियों जैसे अस्थमा के लिए कई दवाएं प्रतिबंधित सूची में शामिल हैं।"
      },
    },
    {
      "myth": {
        "en": "Doping isn’t a problem in golf.",
        "hi": "गोल्फ में डोपिंग कोई समस्या नहीं है।"
      },
      "fact": {
        "en": "Golf is a sport that requires physical strength and endurance as well as concentration and precision. These are attributes that can be unfairly exploited by the use of prohibited substances to the detriment of the integrity of the sport.",
        "hi": "गोल्फ एक ऐसा खेल है जिसमें शारीरिक शक्ति और सहनशक्ति के साथ-साथ ध्यान और सटीकता की आवश्यकता होती है। ये विशेषताएं प्रतिबंधित पदार्थों के उपयोग से खेल की अखंडता को नुकसान पहुंचाने के लिए अनुचित रूप से इस्तेमाल की जा सकती हैं।"
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isHindi = context.watch<LanguageProvider>().isHindi;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isHindi ? "मिथक बनाम तथ्य" : "Myths vs Facts",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mythsAndFacts.length,
        itemBuilder: (context, index) {
          final item = mythsAndFacts[index];
          final colors = [
            Colors.green.shade200,
            Colors.red.shade200,
            Colors.yellow.shade200,
            const Color.fromARGB(255, 178, 130, 255),
          ];
          return Card(
            color: colors[index % colors.length],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Myth Section
                  Text(
                    isHindi ? "मिथक:" : "Myth:",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item["myth"]![isHindi ? "hi" : "en"]!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const Divider(
                    color: Colors.black54,
                    thickness: 1,
                    height: 32,
                  ),
                  // Fact Section
                  Text(
                    isHindi ? "तथ्य:" : "Fact:",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item["fact"]![isHindi ? "hi" : "en"]!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}