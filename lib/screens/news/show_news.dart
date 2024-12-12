import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int selectedCategoryIndex = -1; // For buttons
  int selectedImageIndex = 0; // For horizontal scroll
  bool isLoading = true;
  List<dynamic> horizontalNews = [];
  List<dynamic> verticalNews = [];

  // Replace this with your Mediastack API key
  final String apiKey = '28f1be543a0f534010960d7862868313';

  @override
  void initState() {
    super.initState();
    fetchNews();
  }
Future<void> fetchNews() async {
  try {
    final response = await http.get(
      Uri.parse(
        'http://api.mediastack.com/v1/news?access_key=$apiKey&languages=en&keywords=drugs&limit=18',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Filter news articles with images only
      final filteredNews = data['data']
          .where((news) => news['image'] != null && news['image'].isNotEmpty)
          .toList();

      setState(() {
        horizontalNews = filteredNews.take(3).toList(); // First 3 for horizontal
        verticalNews = filteredNews.skip(3).take(15).toList(); // Next 15 for vertical
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load news');
    }
  } catch (e) {
    print('Error fetching news: $e');
    setState(() {
      isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildHeader(),
                  const SizedBox(height: 10),
                  _buildHorizontalNews(),
                  const SizedBox(height: 20),
                  _buildCategoryButtons(),
                  const SizedBox(height: 10),
                  _buildVerticalNews(),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Latest News',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          TextButton(
            onPressed: () {
              // Navigate to "See All" functionality
            },
            child: const Text(
              'See All >',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalNews() {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: horizontalNews.length,
        controller: PageController(viewportFraction: 1.0),
        itemBuilder: (context, index) {
          final news = horizontalNews[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(news['image'] ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          news['title'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          news['description'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryButtons() {
    final categories = ['World', 'India', 'Regional'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(categories.length, (index) {
          final isSelected = selectedCategoryIndex == index;

          return ElevatedButton(
            onPressed: () {
              setState(() {
                selectedCategoryIndex = index;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? Colors.red : Colors.white,
              foregroundColor: isSelected ? Colors.white : Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(categories[index]),
          );
        }),
      ),
    );
  }

  Widget _buildVerticalNews() {
  return Column(
    children: verticalNews.map((news) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              news['image'] ?? 'https://via.placeholder.com/300',
              height: 150,
              width: 360,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news['published_at'] ?? '',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    news['title'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    news['description'] ?? '',
                    style: const TextStyle(fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedNewsScreen(
                            headline: news['title'] ?? '',
                            content: news['description'] ?? '',
                            image: news['image'] ?? '',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Read More',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}
}

class DetailedNewsScreen extends StatelessWidget {
  final String headline;
  final String content;
  final String image;

  const DetailedNewsScreen({
    required this.headline,
    required this.content,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(image, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headline,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    content,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}