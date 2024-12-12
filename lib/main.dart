import 'package:athlete_aware/firebase/firebase_options.dart';
import 'package:athlete_aware/firebase/wrapper.dart';
import 'package:athlete_aware/providers/user_provider.dart';
import 'package:athlete_aware/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:athlete_aware/providers/language_provider.dart'; // Import LanguageProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(), // Add LanguageProvider
        ),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Athlete Aware',
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: mobileBackgroundColor,
            ),
            home: const Wrapper(),
            locale: Locale(languageProvider.isHindi ? 'hi' : 'en'), // Set app locale
          );
        },
      ),
    );
  }
}
