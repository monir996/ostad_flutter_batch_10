import 'package:flutter/material.dart';

class TaskCountSummaryCard extends StatelessWidget {

  final String title;
  final int count;

  const TaskCountSummaryCard({
    super.key, required this.title, required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$count', style: Theme.of(context).textTheme.titleLarge),
            Text(title, maxLines: 1)
          ],
        ),
      ),
    );
  }
}