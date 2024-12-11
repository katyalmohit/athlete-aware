import 'package:athlete_aware/responsive/mobile_screen_layout.dart';
import 'package:athlete_aware/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<String> imageList = [
    'assets/carousel1.png',
    'assets/carousel2.png',
    'assets/carousel3.png',
  ];

  bool _isHindi = false; // Track language toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isHindi = !_isHindi; // Toggle the language
              });
            },
            icon: Icon(
              _isHindi ? Icons.language : Icons.translate,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Carousel for images
            CarouselSlider(
              items: imageList.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height, // Full screen height
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                height: MediaQuery.of(context).size.height, // Full screen height
                viewportFraction: 1.0, // Ensures only one image is visible at a time
              ),
            ),
            // Text and Button below the carousel image
            Positioned(
              bottom: 40, // Adjusted to ensure it's below the image
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Container(
                    width: double.infinity,
                    height: 60.0,
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MobileScreenLayout(initialPage: 0), // Navigate to HomeScreen
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 247, 96, 83),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 30.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isHindi ? 'शुरू करें' : 'Get Started', // Change text based on toggle
                            style: GoogleFonts.aBeeZee(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.play_arrow,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 24.0,
                          ),
                        ],
                      ),
                    ),
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
