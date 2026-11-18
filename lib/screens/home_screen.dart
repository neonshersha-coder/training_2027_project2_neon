import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../models/tba_team.dart';
import '../providers/game_providers.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  final TextEditingController teamController = TextEditingController();
  final TextEditingController matchController = TextEditingController();
  final TextEditingController teamNumberController = TextEditingController();

  bool textFieldFilled = false;

  void checkFields() {
    setState(() {
      textFieldFilled = teamController.text.isNotEmpty && matchController.text.isNotEmpty && teamNumberController.text.isNotEmpty;
    });
  }
  @override
  void dispose() {
    super.dispose();
    teamNumberController.dispose();
    teamController.dispose();
    matchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        controller: matchController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: "Enter Match Number",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        onChanged: (textValue) {
                          checkFields();
                          int number = int.tryParse(textValue) ?? 0;
                          ref.read(matchNumberBox.notifier).state = number;
                        },
                      ),
                      const SizedBox(height: 25),

                      ref.watch(eventTeamsProvider).when(
                        loading: () => const LinearProgressIndicator(color: Colors.orange),
                        error: (err, stack) => Text("Error loading TBA teams: $err", style: const TextStyle(color: Colors.orangeAccent)),
                        data: (teams) {
                          teams.sort((a, b) => a.teamNumber.compareTo(b.teamNumber));
                          return DropdownButtonFormField<TBATeam>(
                            dropdownColor: const Color(0xFF5A359C),
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            decoration: const InputDecoration(
                              labelText: "Select Team from TBA Event",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            items: teams.map((team) {
                              return DropdownMenuItem<TBATeam>(
                                value: team,
                                child: Text("${team.teamNumber} - ${team.nickname}"),
                              );
                            }).toList(),
                            onChanged: (selectedTeam) {
                              if (selectedTeam != null) {
                                teamNumberController.text = selectedTeam.teamNumber.toString();
                                teamController.text = selectedTeam.nickname;
                                ref.read(teamNumberBox.notifier).state = selectedTeam.teamNumber;
                                ref.read(teamNameBox.notifier).state = selectedTeam.nickname;
                                checkFields();
                              }
                            },
                          );
                        },
                      ),

                      TextField(
                        controller: teamNumberController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: "Enter Team Number",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        onChanged: (textValue) {
                          checkFields();
                          int number = int.tryParse(textValue) ?? 0;
                          ref.read(teamNumberBox.notifier).state = number;
                        },
                      ),
                      const SizedBox(height: 25),

                      TextField(
                        controller: teamController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: "Enter Team Name",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        onChanged: (textValue) {
                          checkFields();
                          ref.read(teamNameBox.notifier).state = textValue;
                        },
                      ),
                      const SizedBox(height: 40),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                          backgroundColor: textFieldFilled ? Colors.orange : const Color(0xFFDCAEAE),
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          int currentMatch = int.tryParse(matchController.text) ?? 0;
                          int currentTeam = int.tryParse(teamNumberController.text) ?? 0;
                          String currentName = teamController.text.trim();

                          if (currentMatch == 0 || currentTeam == 0 || currentName.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Please fill out Match Number with integer(s), Team Number integer(s), and Team Name character(s) before continuing."),
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

                            ref.read(matchNumberBox.notifier).state = currentMatch;
                            ref.read(teamNumberBox.notifier).state = currentTeam;
                            ref.read(teamNameBox.notifier).state = currentName;

                            ref.read(coralL1.notifier).reset();
                            ref.read(coralL2.notifier).reset();
                            ref.read(coralL3.notifier).reset();
                            ref.read(coralL4.notifier).reset();
                            ref.read(processedAlgae.notifier).reset();
                            ref.read(unprocessedAlgae.notifier).reset();
                            ref.read(algaeNet.notifier).reset();

                            matchController.clear();
                            teamNumberController.clear();
                            teamController.clear();
                            setState(() {
                              textFieldFilled = false;
                            });

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