import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFA793CD),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Reefscape Scouting",
            style: GoogleFonts.nunito(
              fontSize: 45.0,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF5A359C),
                Color(0xFF7149B5),
                Color(0xFFA793CD),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

