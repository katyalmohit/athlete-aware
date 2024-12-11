import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(
            top: 120, // Adjust this value to shift the image downwards
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/Designer.png',
              fit: BoxFit.cover,
              width: 650,
              height: 650,
            ),
          ),
          SafeArea(
            child: child!,
          ),
        ],
      ),
    );
  }
}
