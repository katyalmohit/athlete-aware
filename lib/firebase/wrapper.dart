import 'package:athlete_aware/responsive/mobile_screen_layout.dart';
import 'package:athlete_aware/responsive/responsive_layout_screen.dart';
import 'package:athlete_aware/responsive/web_screen_layout.dart';
import 'package:athlete_aware/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:athlete_aware/providers/language_provider.dart'; // Import LanguageProvider

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final isHindi = context.watch<LanguageProvider>().isHindi; // Access language preference

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the connection is active
        if (snapshot.connectionState == ConnectionState.active) {
          // Check if the user is authenticated
          if (snapshot.hasData) {
            // Get Firestore user data
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .get(),
              builder: (context, userSnapshot) {
                // Firestore call is still loading
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.red,
                    ),
                  );
                }

                // Handle Firestore error
                if (userSnapshot.hasError) {
                  return Center(
                    child: Text(
                      isHindi
                          ? 'त्रुटि: ${userSnapshot.error}'
                          : 'Error: ${userSnapshot.error}',
                    ),
                  );
                }

                // Data fetched successfully
                if (userSnapshot.hasData && userSnapshot.data != null) {
                  var userData = userSnapshot.data!;
                  String status = userData['status'];
                  String role = userData['role'];

                  // Check user status
                  if (status == 'blocked') {
                    return Scaffold(
                      backgroundColor: Colors.white,
                      body: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.block,
                                color: Colors.red,
                                size: 80,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                isHindi
                                    ? "आपको ब्लॉक कर दिया गया है।"
                                    : "You've been blocked.",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                isHindi
                                    ? "कृपया हमारे ग्राहक सहायता से संपर्क करें।"
                                    : "For any inquiries, please contact our customer support.",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut(); // Sign out
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const WelcomeScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  isHindi ? 'लॉगिन पर जाएं' : 'Go to Login',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  // User is active, navigate based on their role
                  if (status == 'active') {
                    if (role == 'Athlete') {
                      return const ResponsiveLayout(
                        webScreenLayout: WebScreenLayout(),
                        mobileScreenLayout:
                            MobileScreenLayout(initialPage: 0),
                      );
                    }
                  }
                }

                // If user data is unavailable, show WelcomeScreen
                return const WelcomeScreen();
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                isHindi
                    ? 'त्रुटि: ${snapshot.error}'
                    : 'Error: ${snapshot.error}',
              ),
            );
          }
        }

        // If the connection is waiting (loading)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitFadingCircle(
              color: Colors.red,
            ),
          );
        }

        // If user is not authenticated, show WelcomeScreen
        return const WelcomeScreen();
      },
    );
  }
}
