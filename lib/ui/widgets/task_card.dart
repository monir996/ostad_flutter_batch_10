import 'package:flutter/material.dart';

enum TaskType {
  tNew,
  progress,
  completed,
  canceled
}

class TaskCard extends StatelessWidget {
  final TaskType taskType;

  const TaskCard({
    super.key, required this.taskType,
  });

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
            Text('Title', style: Theme.of(context).textTheme.titleMedium),
            Text('Description', style: TextStyle(color: Colors.grey),),
            Text('Date: 12/12/12', style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  backgroundColor: _getTaskChipColor(),
                  label: Text(_getTaskTypeName(), style: TextStyle( fontSize: 13, color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide.none
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete_forever_outlined, color: Colors.red,)),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getTaskChipColor() {

    switch(taskType) {
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

  String _getTaskTypeName(){
    switch(taskType) {
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
}

