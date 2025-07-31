import 'package:assignment_04/ui/controllers/new_task_list_controller.dart';
import 'package:assignment_04/ui/controllers/sign_in_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(NewTaskListController());
  }
}