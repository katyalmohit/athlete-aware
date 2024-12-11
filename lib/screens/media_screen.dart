
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;class PostsSection extends StatefulWidget {
  @override
  _PostsSectionState createState() => _PostsSectionState();
}

class _PostsSectionState extends State<PostsSection> {
  // Local assets for images
  final List<String> images = [
    "assets/post1.jpg",
    "assets/post2.jpg",
    "assets/post3.jpg",
  ];

  // YouTube video links
  final List<String> youtubeLinks = [
    "https://youtu.be/QdaYElTxW9U?si=Ayv96ET-afhLOmaK",
    "https://youtu.be/QdaYElTxW9U?si=Ayv96ET-afhLOmaK",
    "https://youtu.be/QdaYElTxW9U?si=Ayv96ET-afhLOmaK",
  ];

  late final List<Map<String, dynamic>> posts;

  @override
  void initState() {
    super.initState();
    posts = List.generate(
      images.length + youtubeLinks.length,
      (index) => {
        "username": "user_$index",
        "role": index % 3 == 0
            ? "Athlete"
            : index % 3 == 1
                ? "Coach"
                : "Anti-Doping Advocate",
        "media": index % 2 == 0
            ? images[index % images.length]
            : youtubeLinks[index % youtubeLinks.length],
        "type": index % 2 == 0 ? "image" : "video",
        "timeAgo": "${(index + 1) * 5}m", // Mock time ago
        "upvotes": 0,
        "downvotes": 0,
        "comments": [
          {"username": "user1", "comment": "This is insightful!", "time": "5m"},
          {"username": "user2", "comment": "Great message!", "time": "10m"},
        ],
      },
    );
  }

  void showComments(BuildContext context, List<Map<String, String>> comments) {
    TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: const [
                        Text(
                          "Comments",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      reverse: true, // Most recent comments at the top
                      shrinkWrap: true,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Text(comment['username']![0]),
                          ),
                          title: Text(
                            comment['username']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(comment['comment']!),
                          trailing: Text(
                            comment['time']!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: const InputDecoration(
                              hintText: "Write a comment...",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              comments.insert(
                                0, // Add new comments at the top
                                {
                                  "username": "CurrentUser",
                                  "comment": commentController.text,
                                  "time": "Just now",
                                },
                              );
                            });
                            commentController.clear();
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _launchYouTube(String url) async {
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

  void showSmileyAnimation(BuildContext context, String emoji) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 100, color: Colors.orange),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);

    Future.delayed(const Duration(milliseconds: 500), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with user details
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Text(post['username'][0]),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['username'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            post['role'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        post['timeAgo'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Media Section (Image or Video)
                post['type'] == 'image'
                    ? Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(post['media']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ):
                    GestureDetector(
  onTap: () => _launchYouTube(post['media']),
  child: Stack(
    alignment: Alignment.center,
    children: [
      Image.network(
        // Parse YouTube video ID safely
        _getYouTubeThumbnail(post['media']),
        fit: BoxFit.cover,
        height: 200,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            color: Colors.grey,
            child: const Center(
              child: Text(
                "Video Thumbnail Not Available",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
      const Icon(
        Icons.play_circle_outline,
        size: 50,
        color: Colors.white,
      ),
    ],
  ),
),

                // Actions (Upvote, Downvote, Comments)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                posts[index]['upvotes']++;
                              });
                              showSmileyAnimation(context, "😊");
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.thumb_up_alt_outlined),
                                const SizedBox(width: 4),
                                Text(posts[index]['upvotes'].toString()),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                posts[index]['downvotes']++;
                              });
                              showSmileyAnimation(context, "😞");
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.thumb_down_alt_outlined),
                                const SizedBox(width: 4),
                                Text(posts[index]['downvotes'].toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => showComments(context, post['comments']),
                        child: Row(
                          children: const [
                            Icon(Icons.comment_outlined),
                            SizedBox(width: 8),
                            Text("View Comments"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
String _getYouTubeThumbnail(String url) {
  try {
    final uri = Uri.parse(url);

    // Check for standard YouTube link with 'v' parameter
    if (uri.queryParameters.containsKey('v')) {
      return "https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg";
    }

    // Handle shortened YouTube links like https://youtu.be/VIDEO_ID
    if (uri.host == "youtu.be") {
      final videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      if (videoId != null && videoId.isNotEmpty) {
        return "https://img.youtube.com/vi/$videoId/0.jpg";
      }
    }

    // Fallback for invalid URLs
    return "https://via.placeholder.com/500x300.png?text=Thumbnail+Unavailable";
  } catch (e) {
    // Fallback for parsing errors
    return "https://via.placeholder.com/500x300.png?text=Thumbnail+Unavailable";
  }
}

}