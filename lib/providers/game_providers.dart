import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/tba_team.dart';

final matchNumberBox = StateProvider<int>((ref) => 0);
final teamNumberBox = StateProvider<int>((ref) => 0);
final teamNameBox = StateProvider<String>((ref) => "");


final eventTeamsProvider = FutureProvider<List<TBATeam>>((ref) async {
  return fetchEventTeams("2025waahs");
});

class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void increment() => state++;
  void decrement() { if (state > 0) state--; }
  int reset() => state = 0;
}

final coralL1 = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);
final coralL2 = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);
final coralL3 = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);
final coralL4 = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);
final processedAlgae = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);
final unprocessedAlgae = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);
final algaeNet = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);