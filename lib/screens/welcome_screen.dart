import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
    'assets/carousel4.png',
    // Add more image paths here
  ];

  int _currentIndex = 0; // To track the current carousel index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background color
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
                      height: MediaQuery.of(context)
                          .size
                          .height, // Full screen height
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                height:
                    MediaQuery.of(context).size.height, // Full screen height
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                viewportFraction:
                    1.0, // Ensures only one image is visible at a time
              ),
            ),
            // Carousel Dots in the middle of the image
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.45, // Middle of the image vertically
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => {},
                    child: Container(
                      width: _currentIndex == entry.key ? 14.0 : 10.0,
                      height: _currentIndex == entry.key ? 14.0 : 10.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == entry.key
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Text and Button below the carousel image
            Positioned(
              bottom: 40, // Adjusted to ensure it's below the image
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Empowering Athletes with\nAnti-Doping Knowledge',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.zcoolXiaoWei(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 60),
                  Container(
                    width: double.infinity,
                    height: 60.0,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const WelcomeScreen()), // Navigate to HomeScreen
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 30.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Get Started',
                            style: GoogleFonts.aBeeZee(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.black,
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
