import 'dart:convert';

import 'package:http/http.dart' as http;

class TBATeam {
  final int teamNumber;
  final String nickname;

  TBATeam({required this.teamNumber, required this.nickname});

  factory TBATeam.fromJson(Map<String, dynamic> json) {
    return TBATeam(
      teamNumber: json['team_number'] ?? 0,
      nickname: json['nickname'] ?? 'Unknown Team',
    );
  }
}

Future<List<TBATeam>> fetchEventTeams(String eventKey) async {
  const String tbaApiKey = "hCN0sofO5WBe6LHi09e38ohUOeTSD7t94MQjB7bTyLZzWxFJZooY9fht9wRoftyC";
  final url = Uri.parse('https://www.thebluealliance.com/api/v3/event/$eventKey/teams/simple');

  try {
    final response = await http.get(
      url,
      headers: {'X-TBA-Auth-Key': tbaApiKey},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => TBATeam.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load teams (Status: ${response.statusCode})');
    }
  } catch (e) {
    return [];
  }
}