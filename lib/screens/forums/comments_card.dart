import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentsCard extends StatefulWidget {
  final String postId;

  const CommentsCard({super.key, required this.postId});

  @override
  _CommentsCardState createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  final TextEditingController _commentController = TextEditingController();
  final Map<String, TextEditingController> _replyControllers = {};
  final Map<String, bool> _showReplies =
      {}; // Tracks which comments have replies shown
  String _activeReplyCommentId = ""; // Tracks which comment is being replied to

  // Add a new comment
  Future<void> _addComment() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in to comment.")),
      );
      return;
    }

    final userName = (await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get())
            .data()?['name'] ??
        'Anonymous';

    if (_commentController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('forum_posts')
          .doc(widget.postId)
          .collection('comments')
          .add({
        'userId': user.uid,
        'userName': userName,
        'comment': _commentController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Increment the comments count in the forum_posts collection
      await FirebaseFirestore.instance
          .collection('forum_posts')
          .doc(widget.postId)
          .update({
        'comments': FieldValue.increment(1),
      });

      _commentController.clear();
    }
  }

  // Add a reply to a comment
  Future<void> _addReply(String commentId) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in to reply.")),
      );
      return;
    }

    final userName = (await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get())
            .data()?['name'] ??
        'Anonymous';

    final replyController = _replyControllers[commentId];
    if (replyController != null && replyController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('forum_posts')
          .doc(widget.postId)
          .collection('comments')
          .doc(commentId)
          .collection('replies')
          .add({
        'userId': user.uid,
        'userName': userName,
        'reply': replyController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      replyController.clear();
      setState(() {
        _activeReplyCommentId = ""; // Collapse the reply box after submitting
      });
    }
  }

  // Delete a comment
  Future<void> _deleteComment(String commentId) async {
    await FirebaseFirestore.instance
        .collection('forum_posts')
        .doc(widget.postId)
        .collection('comments')
        .doc(commentId)
        .delete();

    // Decrement the comments count in the forum_posts collection
    await FirebaseFirestore.instance
        .collection('forum_posts')
        .doc(widget.postId)
        .update({
      'comments': FieldValue.increment(-1),
    });
  }

  // Delete a reply to a comment
  Future<void> _deleteReply(String commentId, String replyId) async {
    await FirebaseFirestore.instance
        .collection('forum_posts')
        .doc(widget.postId)
        .collection('comments')
        .doc(commentId)
        .collection('replies')
        .doc(replyId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(106, 181, 36, 36),
        foregroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Comments",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // List of Comments
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('forum_posts')
                  .doc(widget.postId)
                  .collection('comments')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final comments = snapshot.data?.docs ?? [];
                if (comments.isEmpty) {
                  return const Center(child: Text("No comments yet."));
                }

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    final commentId = comment.id;
                    final isOwner = comment['userId'] ==
                        FirebaseAuth.instance.currentUser?.uid;

                    _replyControllers.putIfAbsent(
                        commentId, () => TextEditingController());

                    return Card(
                      color: const Color.fromARGB(237, 255, 255, 255),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: const CircleAvatar(
                                backgroundImage: AssetImage('assets/icon.jpg'),
                              ),
                              title: Text(
                                comment['userName'] ?? 'Anonymous',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 62, 63, 64),
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                comment['comment'] ?? '',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 85, 91, 107),
                                ),
                              ),
                              trailing: isOwner
                                  ? IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red,size: 28,),
                                      onPressed: () =>
                                          _deleteComment(commentId),
                                    )
                                  : null,
                            ),
                            // Reduced space here
                            const SizedBox(
                                height:
                                    3), // Added a small gap between comment and actions
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_activeReplyCommentId ==
                                            commentId) {
                                          // If the reply text field is already open, close it
                                          _activeReplyCommentId = "";
                                        } else {
                                          // Open the reply text field for this comment
                                          _activeReplyCommentId = commentId;
                                        }
                                      });
                                    },
                                    child: const Text(
                                      "Reply",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _showReplies[commentId] =
                                            !(_showReplies[commentId] ?? false);
                                      });
                                    },
                                    child: Text(
                                      _showReplies[commentId] ?? false
                                          ? "Hide Replies"
                                          : "View Replies",
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                                height:
                                    12), // Added extra spacing after actions
                            if (_activeReplyCommentId == commentId)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            _replyControllers[commentId],
                                        decoration: const InputDecoration(
                                          hintText: "Write a reply...",
                                          filled: true,
                                          fillColor: Color.fromARGB(255, 129, 126, 126),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(width: 10),
                                    IconButton(
                                      icon: const Icon(Icons.send,
                                          color: Colors.blue),
                                      onPressed: () => _addReply(commentId),
                                    ),
                                  ],
                                ),
                              ),
                            if (_showReplies[commentId] ?? false)
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0), // Space added before replies
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('forum_posts')
                                      .doc(widget.postId)
                                      .collection('comments')
                                      .doc(commentId)
                                      .collection('replies')
                                      .orderBy('timestamp', descending: true)
                                      .snapshots(),
                                  builder: (context, replySnapshot) {
                                    if (!replySnapshot.hasData) {
                                      return const SizedBox.shrink();
                                    }
                                    final replies =
                                        replySnapshot.data?.docs ?? [];
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: replies.length,
                                      itemBuilder: (context, replyIndex) {
                                        final reply = replies[replyIndex];
                                        final isReplyOwner = reply['userId'] ==
                                            FirebaseAuth
                                                .instance.currentUser?.uid;

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 4.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                child: Icon(Icons.reply,
                                                    color: Color.fromARGB(
                                                        255, 96, 92, 92)),
                                                radius: 12,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      reply['userName'] ??
                                                          'Anonymous',
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                        color: Color.fromARGB(
                                                            163, 255, 0, 0),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      reply['reply'] ?? '',
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(
                                                            221, 0, 0, 0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (isReplyOwner)
                                                IconButton(
                                                  icon: const Icon(Icons.delete,
                                                      color: Colors.red,
                                                      size: 18),
                                                  onPressed: () => _deleteReply(
                                                      commentId, reply.id),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Input for new comments
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Add a comment...",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
