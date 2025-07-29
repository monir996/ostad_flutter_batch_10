import 'package:assignment_04/ui/widgets/task_card.dart';
import 'package:flutter/material.dart';

class CanceledTaskListScreen extends StatefulWidget {
  const CanceledTaskListScreen({super.key});

  @override
  State<CanceledTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<CanceledTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          return TaskCard(
            taskType: TaskType.canceled,
          );
        },
      ),
    );
  }
}
