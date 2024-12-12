import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoScreen extends StatelessWidget {
  final Map<String, List<Map<String, String>>> videoSections = {
    "About Anti-Doping": [
      {
        "url": "https://www.youtube.com/watch?v=qscWqUhYnx0",
        "title": "What is Anti-Doping?",
      },
      {
        "url": "https://youtu.be/z466itSHE58?si=LH6sig46CY9WrTPx",
        "title": "The History of Anti-Doping",
      },
      {
        "url": "https://youtu.be/G43qcn-FV7Q?si=Xj-CAA5lIBvGJ9MN",
        "title": "Understanding the Basics",
      },
      {
        "url": "https://youtu.be/sWhudwnE3Fg?si=wkyRaEj9vmrOiEQM",
        "title": "Key Challenges",
      },
      {
        "url": "https://youtu.be/5vdxQtskfPM?si=r4LYXONlouWOdSWG",
        "title": "Benefits of Clean Sports",
      },
    ],
    "Rules and Regulations": [
      {
        "url": "https://youtu.be/ctUbf3lBZcc?si=NT5XryX_hE7aBmko",
        "title": "WADA Rules Explained",
      },
      {
        "url": "https://youtu.be/ctUbf3lBZcc?si=mjN8MjDMZm6DKTFb",
        "title": "NADA Guidelines for Athletes",
      },
      {
        "url": "https://youtu.be/mjBvX1hFsbI?si=URiyJilFWpvrWtZl",
        "title": "Understanding Bans",
      },
      {
        "url": "https://youtu.be/6TOmaBSvbds?si=ey9ZLEvzruCjEa94",
        "title": "Legal Supplements",
      },
      {
        "url": "https://youtu.be/UZTfhRv-Mik?si=n5HWJV5GVZxiLXWm",
        "title": "Therapeutic Use Exemptions",
      },
    ],
    "Healthy Practices": [
      {
        "url": "https://www.youtube.com/watch?v=v-S8zK5pREM",
        "title": "Staying Fit Naturally",
      },
      {
        "url": "https://youtu.be/rRY_K_UxxFM?si=Sm6DqGLtoAx1ot5s",
        "title": "Tips for Clean Performance",
      },
      {
        "url": "https://youtu.be/GQ2erkpKnEg?si=3mMc9caGKueymBQM",
        "title": "Mental Well-being",
      },
      {
        "url": "https://www.youtube.com/live/e5V92zcGnXI?si=Ts98DnR83-57g0JZ",
        "title": "Nutrition Tips",
      },
      {
        "url": "https://youtu.be/p2qvxy84Jgw?si=-pFX6OTMB0Nl_bEc",
        "title": "Hydration Strategies",
      },
    ],
    "Why Anti-Doping is Important": [
      {
        "url": "https://youtu.be/FCWMx9uJWPM?si=ZX6r0Ia0LshiRhwb",
        "title": "Impact on Fair Play",
      },
      {
        "url": "https://youtu.be/BJsIWTYRQU0?si=0TWVjT6k9lAf8qlB",
        "title": "Protecting Athletes' Health",
      },
      {
        "url": "https://youtu.be/BJsIWTYRQU0?si=0TWVjT6k9lAf8qlB",
        "title": "Integrity in Sports",
      },
      {
        "url": "https://www.youtube.com/live/qscWqUhYnx0?si=VH3AiOQ8RIyTIlLi",
        "title": "Building Trust",
      },
      {
        "url": "https://youtu.be/qfBZ-HTMK9o?si=IY0yT_fyXGJhDYqv",
        "title": "Global Impact",
      },
    ],
    "Podcasts": [
      {
        "url": "https://youtu.be/Y6jSq7DyTxM?si=ThLyXRXAYihqualt",
        "title": "Anti-Doping Discussions",
      },
      {
        "url": "https://youtu.be/u1Tq_rp4c3Q?si=g0Ms9TfvbFSSTrc2",
        "title": "Interviews with Athletes",
      },
      {
        "url": "https://youtu.be/worfiqmdx_U?si=XRv7jJ8pEwLo6EwL",
        "title": "Experts' Opinions",
      },
      {
        "url": "https://youtu.be/PrObCIzLkD4?si=9oRXTtQlR4b4t-bT",
        "title": "Policy Updates",
      },
      {
        "url": "https://youtu.be/XfNomOxT7sQ?si=MLzJ-REDeVO9oEaD",
        "title": "Policy Updates",
      },
      
    ],
  };

  // Function to extract video ID from YouTube URL
  String _extractVideoId(String url) {
    final uri = Uri.parse(url);
    return uri.queryParameters['v'] ?? uri.pathSegments.last;
  }

  // Function to open YouTube link
  Future<void> _launchUrl(String url) async {
     try {
      // Parse the URL
      var uri = Uri.parse(url);
      // Directly attempt to launch the URL
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Open in external browser or app
      );
    } catch (e) {
      // Handle the error gracefully
      debugPrint('Error launching URL: $e');
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anti-Doping Video Resources"),
        backgroundColor: const Color.fromARGB(179, 0, 159, 244),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: videoSections.entries.map((entry) {
          final sectionTitle = entry.key;
          final videoLinks = entry.value;

          return Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16,),
              Text(
                sectionTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 4),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: videoLinks.map((video) {
                    final videoId = _extractVideoId(video["url"]!);
                    final thumbnailUrl = "https://img.youtube.com/vi/$videoId/0.jpg";

                    return GestureDetector(
                      onTap: () => _launchUrl(video["url"]!),
                      child: Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 16.0),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.network(
                                  thumbnailUrl,
                                  height: 100,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                const Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              video["title"]!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }
}