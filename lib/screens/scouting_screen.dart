import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';


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
                child: Column(
                children: [
                 GridView.count(
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
                          final int l1Points = l1Count * 3;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Coral L1",
                                        style: GoogleFonts.nunito(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Score: $l1Points",
                                        style: GoogleFonts.nunito(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.orangeAccent,
                                        ),
                                      ),
                                    ],
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
                          final l2Count = ref.watch(coralL2);
                          final int l2Points = l2Count * 4;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text(
                                    "Coral L2",
                                    style: GoogleFonts.nunito(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                      Text(
                                    "$l2Points",
                                  style: GoogleFonts.nunito(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orangeAccent,
                                  ),
                          ),
                          ],
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 12.0),
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
                                        onPressed: () =>
                                            ref
                                                .read(coralL3.notifier)
                                                .decrement(),
                                        icon: const Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.white),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
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
                                        onPressed: () =>
                                            ref
                                                .read(coralL3.notifier)
                                                .increment(),
                                        icon: const Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.white),
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
                                  border: Border.all(color: Colors.white
                                      .withValues(alpha: 0.2), width: 1.0),
                                ),
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    final l4Count = ref.watch(coralL4);
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 12.0),
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
                                                onPressed: () =>
                                                    ref
                                                        .read(coralL4.notifier)
                                                        .decrement(),
                                                icon: const Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.white),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 10.0),
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
                                                onPressed: () =>
                                                    ref
                                                        .read(coralL4.notifier)
                                                        .increment(),
                                                icon: const Icon(
                                                    Icons.add_circle_outline,
                                                    color: Colors.white),
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
                                  border: Border.all(color: Colors.white
                                      .withValues(alpha: 0.2), width: 1.0),
                                ),
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    final processedAlgaeCount = ref.watch(
                                        processedAlgae);
                                    final processedAlgaePoints = processedAlgaeCount *
                                        6;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 12.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                "Processed Algae",
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
                                                onPressed: () =>
                                                    ref
                                                        .read(
                                                        processedAlgae.notifier)
                                                        .decrement(),
                                                icon: const Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.white),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 10.0),
                                                child: Text(
                                                  "$processedAlgaeCount",
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () =>
                                                    ref
                                                        .read(
                                                        processedAlgae.notifier)
                                                        .increment(),
                                                icon: const Icon(
                                                    Icons.add_circle_outline,
                                                    color: Colors.white),
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
                                  border: Border.all(color: Colors.white
                                      .withValues(alpha: 0.2), width: 1.0),
                                ),
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    final unprocessedAlgaeCount = ref.watch(
                                        unprocessedAlgae);
                                    final unprocessedAlgaePoints = unprocessedAlgaeCount *
                                        2;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 12.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Unprocessed Algae",
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
                                                onPressed: () =>
                                                    ref
                                                        .read(unprocessedAlgae
                                                        .notifier)
                                                        .decrement(),
                                                icon: const Icon(
                                                    Icons.remove_circle_outline,
                                                    color: Colors.white),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 10.0),
                                                child: Text(
                                                  "$unprocessedAlgaeCount",
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () =>
                                                    ref
                                                        .read(unprocessedAlgae
                                                        .notifier)
                                                        .increment(),
                                                icon: const Icon(
                                                    Icons.add_circle_outline,
                                                    color: Colors.white),
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
                                  border: Border.all(color: Colors.white
                                      .withValues(alpha: 0.2), width: 1.0),
                                ),
                                child: Consumer(
                                    builder: (context, ref, child) {
                                      final netCount = ref.watch(algaeNet);
                                      final netPoints = netCount * 4;
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 12.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Algae Net",
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
                                                    onPressed: () =>
                                                        ref
                                                            .read(
                                                            algaeNet.notifier)
                                                            .decrement(),
                                                    icon: const Icon(Icons
                                                        .remove_circle_outline,
                                                        color: Colors.white),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10.0),
                                                    child: Text(
                                                      "$netCount",
                                                      style: GoogleFonts.nunito(
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight
                                                            .w900,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () =>
                                                        ref
                                                            .read(
                                                            algaeNet.notifier)
                                                            .increment(),
                                                    icon: const Icon(Icons
                                                        .add_circle_outline,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                      );
                                    }
                                ),
                              ),
                  ],
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
  int reset() {
    return state = 0;
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
  int reset() {
    return state = 0;
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
  int reset() {
    return state = 0;
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
  int reset() {
    return state = 0;
  }
}

final coralL4 = NotifierProvider<CoralL4, int>(CoralL4.new);

class ProcessedAlgae extends Notifier<int> {
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
  int reset() {
    return state = 0;
  }
}

final processedAlgae = NotifierProvider<ProcessedAlgae, int>(ProcessedAlgae.new);


class UnprocessedAlgae extends Notifier<int> {
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
  int reset() {
    return state = 0;
  }
}

final unprocessedAlgae = NotifierProvider<UnprocessedAlgae, int>(UnprocessedAlgae.new);

class AlgaeNet extends Notifier<int> {
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
  int reset() {
    return state = 0;
  }
}

final algaeNet = NotifierProvider<AlgaeNet, int>(AlgaeNet.new);