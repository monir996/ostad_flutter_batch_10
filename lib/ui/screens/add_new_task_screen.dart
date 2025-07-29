import 'package:assignment_04/ui/widgets/common_appbar.dart';
import 'package:assignment_04/ui/widgets/screen_background.dart';
import 'package:flutter/material.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = '/add-new-task';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                    controller: _titleTEController,
                    decoration: InputDecoration(hintText: 'Title'),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your title';
                      }
                      return null;
                    },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionTEController,
                  maxLines: 5,
                  decoration: InputDecoration(hintText: 'Description'),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter your description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onTapSubmitButton,
                  child: Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton(){
    if(_formkey.currentState!.validate()){

    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
