import 'package:assignment_04/ui/widgets/task_card.dart';
import 'package:flutter/material.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<CompletedTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          return TaskCard(
            taskType: TaskType.completed,
          );
        },
      ),
    );
  }
}
