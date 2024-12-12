import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'forum_service.dart';
import 'comments_card.dart';
import 'package:timeago/timeago.dart' as timeago;

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final TextEditingController _controller = TextEditingController();
  File? _selectedFile;
  bool isAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 49, 200, 226),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Forum",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Column(
        children: [
          // Posts List
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: ForumService.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching posts"));
                }

                final posts = snapshot.data?.docs ?? [];

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot post = posts[index];
                    return _buildPostCard(
                      context,
                      user: post['userName'],
                      time: post['time'],
                      text: post['message'],
                      image: post['fileUrl'] ?? '',
                      likes: post['likes'],
                      comments: post['comments'],
                      postId: post.id, // Pass the document ID
                    );
                  },
                );
              },
            ),
          ),

          const Divider(height: 1, color: Colors.grey),

          // New Post Section at the Bottom
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // File Picker Button
                IconButton(
                  onPressed: _pickFile,
                  icon: const Icon(
                    Icons.attach_file,
                    color: Colors.grey,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 1),
                // Input Field
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _controller,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Write something...",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      filled: true,
                      fillColor: const Color.fromARGB(153, 109, 160, 202),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Send Icon Button
                IconButton(
                  onPressed: _sendPost,
                  icon: const Icon(Icons.send, color: Colors.blue, size: 28),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(
    BuildContext context, {
    required String user,
    required String time,
    required String text,
    required String image,
    required int likes, // Treating likes as an integer
    required int comments, // Treating comments as an integer
    required String postId, // Accept postId for navigation
  }) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: const AssetImage(
                    'assets/icon.jpg'), // Load image from assets
                backgroundColor:
                    Colors.grey.shade300, // Fallback background color
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.brown),
                  ),
                  Text(
                    timeago.format(
                      DateTime.parse(
                          time), // Ensure time is in ISO 8601 format
                      locale: 'en', // Default is English
                    ),
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
  onPressed: () {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.block, color: Colors.red),
              title: const Text("Block Post", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context); // Close the modal
                _handleBlock(postId); // Call the block handler
              },
            ),
          ],
        );
      },
    );
  },
  icon: const Icon(Icons.more_vert, color: Colors.grey),
),

            ],
          ),
          const SizedBox(height: 6),

          // Post Text
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),

          // Post Image (if exists)
          if (image.isNotEmpty) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: image.endsWith(".mp4")
                  ? GestureDetector(
                      onTap: () {
                        // Handle video playback
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: Text(
                                "Play video functionality to be implemented"),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 200,
                            color: Colors.black12,
                            child: const Center(
                              child: Icon(Icons.play_circle_outline,
                                  size: 50, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Image.network(
                      image,
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
            ),
          ],

          // const SizedBox(height: 1),

          // Action Buttons (Likes, Comments)
          Row(
            children: [
              // Like Button
              IconButton(
                onPressed: () => _handleLike(postId, currentUserId),
                icon: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('forum_posts')
                      .doc(postId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Icon(Icons.thumb_up_alt_outlined,
                          color: Colors.grey);
                    }
                    final post = snapshot.data?.data() as Map<String, dynamic>;
                    final List<dynamic> likedBy = post['likedBy'] ?? [];
                    final isLiked = likedBy.contains(currentUserId);

                    return AnimatedScale(
                      scale: isLiked
                          ? 1.2
                          : 1.0, // Add a slight animation for like
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        isLiked
                            ? Icons.thumb_up_alt
                            : Icons.thumb_up_alt_outlined,
                        color: isLiked ? Colors.blue : Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              // Like Count
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('forum_posts')
                    .doc(postId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('0'); // Default to 0 if no data
                  }
                  final post = snapshot.data?.data() as Map<String, dynamic>;
                  final int likeCount = post['likes'] ?? 0;
                  return Text(
                    '$likeCount',
                    style: const TextStyle(fontSize: 15, color: Colors.black87,fontWeight: FontWeight.bold),
                  );
                },
              ),
              const SizedBox(width: 20),

              // Comment Button
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentsCard(
                          postId: postId), // Navigate to CommentsCard
                    ),
                  );
                },
                icon: const Icon(Icons.comment, color: Color.fromARGB(255, 210, 109, 109)),
              ),

              // Comment Count
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('forum_posts')
                    .doc(postId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('0'); // Default to 0 if no data
                  }
                  final post = snapshot.data?.data() as Map<String, dynamic>;
                  final int commentCount = post['comments'] ?? 0;
                  return Text(
                    '$commentCount',
                    style: const TextStyle(fontSize: 15, color: Colors.black87,fontWeight: FontWeight.bold),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _sendPost() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userId = user.uid;

      // Fetch username from Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final userName = userDoc.data()?['name'] ?? 'Unknown User';

      // Upload file if selected
      String? fileUrl;
      if (_selectedFile != null) {
        fileUrl = await ForumService.uploadFileToFirebase(_selectedFile!);
        if (fileUrl == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("File upload failed. Please try again.")),
          );
          return; // Abort posting if file upload fails
        }
      }

      // Add post to Firestore
      await ForumService.addPostToFirestore(
        message: _controller.text,
        fileUrl: fileUrl,
        userId: userId,
        userName: userName,
      );

      // Clear input and reset state
      _controller.clear();
      setState(() {
        _selectedFile = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
    }
  }

  void _handleLike(String postId, String? currentUserId) async {
    if (currentUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in to like a post.")),
      );
      return;
    }

    final postRef =
        FirebaseFirestore.instance.collection('forum_posts').doc(postId);
    final postSnapshot = await postRef.get();
    final post = postSnapshot.data() as Map<String, dynamic>;
    final List<dynamic> likedBy = post['likedBy'] ?? [];

    if (likedBy.contains(currentUserId)) {
      // If already liked, unlike the post
      await postRef.update({
        'likedBy': FieldValue.arrayRemove([currentUserId]),
        'likes': FieldValue.increment(-1),
      });
    } else {
      // If not liked, like the post
      await postRef.update({
        'likedBy': FieldValue.arrayUnion([currentUserId]),
        'likes': FieldValue.increment(1),
      });
    }
  }
  
void _handleBlock(String postId) async {
  try {
    final postRef = FirebaseFirestore.instance.collection('forum_posts').doc(postId);

    // Increment the blocknumber field
    await postRef.update({
      'blocknumber': FieldValue.increment(1),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Post has been blocked successfully.")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error blocking the post: $e")),
    );
  }
}
}