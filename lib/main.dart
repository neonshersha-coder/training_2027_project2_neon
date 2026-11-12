import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyApp(),
    ),
    GoRoute(
      path: '/scouting',
      builder: (context, state) => const ScoutingScreen(),
    ),
  ],
);




final matchNumberBox = StateProvider<int>((ref) => 0);
final teamNumberBox = StateProvider<int>((ref) => 0);
final teamNameBox = StateProvider<String>((ref) => "");

void main() {
  runApp(
     ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
    ),
  ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(

        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Reefscape Scouting",
            style: GoogleFonts.nunito(
              fontSize: 45.0,
              fontWeight: FontWeight.w900,
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Enter Match Number",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      onChanged: (textValue) {
                        int number = int.tryParse(textValue) ?? 0;
                        ref.read(matchNumberBox.notifier).state = number;
                      },
                    ),
                    const SizedBox(height: 25),

                    TextField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Enter Team Number",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      onChanged: (textValue) {
                        int number = int.tryParse(textValue) ?? 0;
                        ref.read(teamNumberBox.notifier).state = number;
                      },
                    ),
                    const SizedBox(height: 25),

                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Enter Team Name",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                        onChanged: (textValue) {
                        ref.read(teamNameBox.notifier).state = textValue;
                      },
                    ),
              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  backgroundColor: const Color(0xFFDCAEAE),
                  foregroundColor: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                  onPressed: () {
                    int currentMatch = ref.read(matchNumberBox);
                    int currentTeam = ref.read(teamNumberBox);
                    String currentName = ref.read(teamNameBox);

                    if (currentMatch == 0 || currentTeam == 0 || currentName.isEmpty) {
                      showDialog(
                        context: context,
                          builder: (context) {
                          return AlertDialog(
                            title: const Text("Please fill out Match Number, Team Number, and Team Name before continuing."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Back"),
                              ),
                            ],
                          );
                          },
                      );
                    } else {
                      context.go('/scouting');
                    }

                  },
                  child: Text(
                    "Start Scouting",
                    style: GoogleFonts.nunito(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                ),
              ),
              ),
                ]
               ),
              ),
            ),
          ),
        ),
      ),
     );
  }
}


class ScoutingScreen extends ConsumerWidget {
  const ScoutingScreen({super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text("Scouting Screen Page"),
      ),
    );
  }
}
