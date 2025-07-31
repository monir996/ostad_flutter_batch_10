import 'package:assignment_04/data/models/task_model.dart';
import 'package:assignment_04/data/service/network_caller.dart';
import 'package:assignment_04/data/utils.dart';
import 'package:assignment_04/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:assignment_04/ui/widgets/snackbar_message.dart';
import 'package:assignment_04/ui/widgets/task_card.dart';
import 'package:flutter/material.dart';

class CanceledTaskListScreen extends StatefulWidget {
  const CanceledTaskListScreen({super.key});

  @override
  State<CanceledTaskListScreen> createState() => _CanceledTaskListScreenState();
}

class _CanceledTaskListScreenState extends State<CanceledTaskListScreen> {

  bool _getCanceledTasksInProgress = false;
  List<TaskModel> _canceledTaskList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Visibility(
        visible: _getCanceledTasksInProgress == false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.builder(
          itemCount: _canceledTaskList.length,
          itemBuilder: (context, index){
            return TaskCard(
              taskType: TaskType.canceled,
              taskModel: _canceledTaskList[index],
              onStatusUpdate: (){},
            );
          },
        ),
      ),
    );
  }

}
