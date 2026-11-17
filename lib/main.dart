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
                    int currentMatch = ref.read(matchNumberBox);
                    int currentTeam = ref.read(teamNumberBox);
                    String currentName = ref.read(teamNameBox);

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


class ScoutingScreen extends ConsumerStatefulWidget {
  const ScoutingScreen({super.key});

  @override
  ConsumerState<ScoutingScreen> createState() => _ScoutingScreen();
}

class _ScoutingScreen extends ConsumerState<ScoutingScreen> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 120,
        leading: Padding(
           padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              ),
            ),
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.arrow_back),
            label: Text(
              "Back",
              style: GoogleFonts.nunito(
                fontSize: 14.0,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(
          "Reefscape Scouting",
          style: GoogleFonts.nunito(
            fontSize: 26.0,
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
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 3.8,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1.0,
                        ),
                      ),
                      child: Consumer(
                          builder: (context, ref, child) {
                            final l1Count = ref.watch(coralL1);
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Coral L1",
                                      style: GoogleFonts.nunito(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          ref.read(coralL1.notifier).decrement();
                                        },
                                        icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                        child: Text(
                                          "$l1Count",
                                          style: GoogleFonts.nunito(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ref.read(coralL1.notifier).increment();
                                        },
                                        icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.0),
                      ),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final l2Count = ref.watch(coralL2);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Coral L2",
                                    style: GoogleFonts.nunito(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () => ref.read(coralL2.notifier).decrement(),
                                      icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(
                                        "$l2Count",
                                        style: GoogleFonts.nunito(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => ref.read(coralL2.notifier).increment(),
                                      icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.0),
                      ),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final l3Count = ref.watch(coralL3);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Coral L3",
                                    style: GoogleFonts.nunito(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () => ref.read(coralL3.notifier).decrement(),
                                      icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(
                                        "$l3Count",
                                        style: GoogleFonts.nunito(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => ref.read(coralL3.notifier).increment(),
                                      icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.0),
                      ),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final l4Count = ref.watch(coralL4);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Coral L4",
                                    style: GoogleFonts.nunito(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () => ref.read(coralL4.notifier).decrement(),
                                      icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(
                                        "$l4Count",
                                        style: GoogleFonts.nunito(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => ref.read(coralL4.notifier).increment(),
                                      icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
            ),
              ),
        ),

        ),
        ),
        );
  }
}

  class CoralL1 extends Notifier<int> {
    @override
     int build() {
     return 0;
  }
    void increment() {
        state++;
}
    void decrement() {
      if (state > 0) {
        state--;
  }
}
}

final coralL1 = NotifierProvider<CoralL1, int>(CoralL1.new);

class CoralL2 extends Notifier<int> {
  @override
  int build() {
    return 0;
  }
  void increment() {
    state++;
  }
  void decrement() {
    if (state > 0) {
      state--;
    }
  }
}

final coralL2 = NotifierProvider<CoralL2, int>(CoralL2.new);

class CoralL3 extends Notifier<int> {
  @override
  int build() {
    return 0;
  }
  void increment() {
    state++;
  }
  void decrement() {
    if (state > 0) {
      state--;
    }
  }
}

final coralL3 = NotifierProvider<CoralL3, int>(CoralL3.new);

class CoralL4 extends Notifier<int> {
  @override
  int build() {
    return 0;
  }
  void increment() {
    state++;
  }
  void decrement() {
    if (state > 0) {
      state--;
    }
  }
}

final coralL4 = NotifierProvider<CoralL4, int>(CoralL4.new);

