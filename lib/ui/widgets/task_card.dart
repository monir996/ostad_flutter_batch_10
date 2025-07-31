import 'package:assignment_04/data/models/task_model.dart';
import 'package:assignment_04/data/service/network_caller.dart';
import 'package:assignment_04/data/utils.dart';
import 'package:assignment_04/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:assignment_04/ui/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';

enum TaskType { tNew, progress, completed, canceled }

class TaskCard extends StatefulWidget {
  final TaskType taskType;
  final TaskModel taskModel;
  final VoidCallback onStatusUpdate;

  const TaskCard({super.key, required this.taskType, required this.taskModel, required this.onStatusUpdate});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              widget.taskModel.description,
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              'Date: ${widget.taskModel.createdDate}',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  backgroundColor: _getTaskChipColor(),
                  label: Text(
                    _getTaskTypeName(),
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
                Spacer(),

                Visibility(
                  visible: _updateTaskStatusInProgress == false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: IconButton(
                    onPressed: _showEditTaskStatusDialog,
                    icon: Icon(Icons.edit),
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete_forever_outlined, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTaskChipColor() {
    switch (widget.taskType) {
      case TaskType.tNew:
        return Colors.blueAccent;
      case TaskType.progress:
        return Colors.purple;
      case TaskType.completed:
        return Colors.green;
      case TaskType.canceled:
        return Colors.redAccent;
    }
  }

  String _getTaskTypeName() {
    switch (widget.taskType) {
      case TaskType.tNew:
        return 'New';
      case TaskType.progress:
        return 'Progress';
      case TaskType.completed:
        return 'Completed';
      case TaskType.canceled:
        return 'Canceled';
    }
  }

  void _showEditTaskStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('New'),
                trailing: _getTaskStatusTrailing(TaskType.tNew),
                onTap: ()=> _onTapTaskStatus(TaskType.tNew, 'New'),
              ),
              ListTile(
                title: Text('In Progress'),
                trailing: _getTaskStatusTrailing(TaskType.progress),
                onTap: ()=> _onTapTaskStatus(TaskType.progress, 'Progress'),
              ),
              ListTile(
                title: Text('Completed'),
                trailing: _getTaskStatusTrailing(TaskType.completed),
                onTap: ()=> _onTapTaskStatus(TaskType.completed, 'Completed'),
              ),
              ListTile(
                title: Text('Canceled'),
                trailing: _getTaskStatusTrailing(TaskType.canceled),
                onTap: ()=> _onTapTaskStatus(TaskType.canceled, 'Canceled'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget? _getTaskStatusTrailing(TaskType type) {
    return widget.taskType == type ? Icon(Icons.check_circle) : null;
  }

  void _onTapTaskStatus(TaskType type, String status){
    if(type == widget.taskType){
      return;
    }
    _updateTaskStatus(status);
  }

  Future<void> _updateTaskStatus(String status) async {
    Navigator.pop(context);
    _updateTaskStatusInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.updateTaskStatusUrl(widget.taskModel.id, status),
    );

    _updateTaskStatusInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      widget.onStatusUpdate;
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
  }
}
