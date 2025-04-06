/*
* ========== Ostad Flutter Batch-10 Live Test ==========
* Live Test-01
* Name: Mohammad Monir Hossain
* Email: ahmedmonir303@gmail.com
* Phone: 01521439480
* */

import 'dart:convert';

void main() {

  // Sample input
  List<Map<String, dynamic>> students = [
    {"name": "Alice", "scores": [85, 90, 78]},
    {"name": "Bob", "scores": [88, 76, 95]},
    {"name": "Charlie", "scores": [90, 92, 85]}
  ];

  // Calculate averages and create a map
  Map<String, double> averageScores = {};

  for (var student in students) {
    String name = student['name'];
    List<int> scores = List<int>.from(student['scores']);

    double totalScore = 0;
    for (var score in scores) {
      totalScore += score;
    }

    double avg = totalScore / scores.length;
    averageScores[name] = double.parse(avg.toStringAsFixed(2));
  }

  // Sort the map by average score in descending order
  var sorted = averageScores.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  Map<String, double> sortedAverages = Map.fromEntries(sorted);

  // Print the result
  print(JsonEncoder.withIndent('  ').convert(sortedAverages));
}