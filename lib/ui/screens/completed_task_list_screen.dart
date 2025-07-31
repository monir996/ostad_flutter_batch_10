import 'package:assignment_04/data/models/task_model.dart';
import 'package:assignment_04/data/service/network_caller.dart';
import 'package:assignment_04/data/utils.dart';
import 'package:assignment_04/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:assignment_04/ui/widgets/snackbar_message.dart';
import 'package:assignment_04/ui/widgets/task_card.dart';
import 'package:flutter/material.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<CompletedTaskListScreen> {

  bool _getCompletedTasksInProgress = false;
  List<TaskModel> _completedTaskList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Visibility(
        visible: _getCompletedTasksInProgress == false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.builder(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index){
            return TaskCard(
              taskType: TaskType.completed,
              taskModel: _completedTaskList[index],
              onStatusUpdate: () => _getCompletedTaskList(),
            );
          },
        ),
      ),
    );
  }

  Future<void> _getCompletedTaskList() async{
    _getCompletedTasksInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getCompletedTasksUrl);


    if(response.isSuccess){

      List<TaskModel> list = [];

      for(Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _completedTaskList = list;
    } else {
      if(mounted){
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
    _getCompletedTasksInProgress = false;
    if(mounted){
      setState(() {});
    }
  }
}
