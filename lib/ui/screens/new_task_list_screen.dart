import 'package:assignment_04/ui/screens/add_new_task_screen.dart';
import 'package:assignment_04/ui/widgets/task_card.dart';
import 'package:assignment_04/ui/widgets/task_count_summary_card.dart';
import 'package:flutter/material.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _onTapAddNewTaskButton, child: Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.separated(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return TaskCountSummaryCard(count: 12, title: 'Progress');
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 4),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index){
                  return TaskCard(
                    taskType: TaskType.tNew,
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }

  void _onTapAddNewTaskButton(){
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }
}




