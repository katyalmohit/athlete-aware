import 'dart:convert';
import 'package:athlete_aware/screens/message.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class YuvasaathiScreen extends StatefulWidget {
  const YuvasaathiScreen({super.key});

  @override
  State<YuvasaathiScreen> createState() => _YuvasaathiScreenState();
}

class _YuvasaathiScreenState extends State<YuvasaathiScreen> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Message> msgs = [];
  bool isTyping = false;

  void sendMsg() async {
    String text = controller.text;
    String apiKey =
        "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"; // Replace with your OpenRouter API key
    controller.clear();

    try {
      if (text.isNotEmpty) {
        setState(() {
          msgs.insert(0, Message(true, text));
          isTyping = true;
        });
        scrollController.animateTo(0.0,
            duration: const Duration(seconds: 1), curve: Curves.easeOut);

        var response = await http.post(
          Uri.parse("https://openrouter.ai/api/v1/chat/completions"),
          headers: {
            "Authorization": "Bearer $apiKey",
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "model": "gpt-4o-mini",
            "messages": [
              {
                "role": "system",
                "content": """
                  You are YuvaSathi, a trusted friend and guide for young athletes, particularly from grassroots communities in India. 
                  Growing up playing on local fields, YuvaSathi understands both the dreams and challenges that aspiring athletes face. 
                  Having learned about the importance of fair play and integrity, YuvaSathi’s mission is to help others navigate the 
                  ever-evolving world of anti-doping.

                  Your role is to provide clear, accurate, and up-to-date information on anti-doping matters. 
                  Draw on reputable sources such as the World Anti-Doping Agency (WADA), the National Anti-Doping Agency (NADA), 
                  and other recognized authorities. Because anti-doping rules and regulations can change frequently, 
                  always remind users to verify details on the official websites or through their sport’s governing body. 
                  Communicate in the user’s preferred local language whenever possible to ensure accessibility and understanding.

                  You may answer questions about prohibited substances, testing procedures, therapeutic use exemptions, 
                  or any other anti-doping topic. However, if a user’s query strays beyond anti-doping, politely guide them 
                  back to related topics. Do not provide information outside this domain. 
                  Your ultimate goal is to empower athletes with the knowledge and resources they need to compete fairly, 
                  confidently, and cleanly—while also encouraging them to seek the most current and official information as it becomes available.
                """
              },
              {"role": "user", "content": text}
            ]
          }),
        );

        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          setState(() {
            isTyping = false;
            msgs.insert(
              0,
              Message(
                false,
                json["choices"][0]["message"]["content"].toString().trimLeft(),
              ),
            );
          });
          scrollController.animateTo(0.0,
              duration: const Duration(seconds: 1), curve: Curves.easeOut);
        } else {
          throw Exception("API Error: ${response.statusCode}");
        }
      }
    } on Exception catch (e) {
      setState(() {
        isTyping = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Some error occurred: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(179, 0, 159, 244), // Custom AppBar color
        
        title: const Text(
          "YuvaSathi Chat Bot",
          style: TextStyle(color: Colors.white), // Title text style
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage:
                  AssetImage('assets/chatbot.jpeg'), // Chatbot image
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // Icon and Text Display
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                // Text(
                //   '✨ Talk to YuvaSathi - your machine friend 🤖',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontSize: 22,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //   ),
                // ),
                // SizedBox(height: 4),
                // Text(
                //   'Explore anti-doping information in your preferred language',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.grey,
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: msgs.length,
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: isTyping && index == 0
                      ? Column(
                          children: [
                            BubbleNormal(
                              text: msgs[0].msg,
                              isSender: true,
                              color: Colors.blue.shade100,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16, top: 4),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Typing...",
                                  style: TextStyle(
                                      color: Colors
                                          .white), // Set text color to white
                                ),
                              ),
                            ),
                          ],
                        )
                      : BubbleNormal(
                          text: msgs[index].msg,
                          isSender: msgs[index].isSender,
                          color: msgs[index].isSender
                              ? Colors.blue.shade100
                              : Colors.grey.shade200,
                        ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: TextField(
                        controller: controller,
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted: (value) {
                          sendMsg();
                        },
                        textInputAction: TextInputAction.send,
                        showCursor: true,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "Enter text"),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  sendMsg();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}