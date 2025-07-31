import 'package:assignment_04/data/models/task_model.dart';
import 'package:assignment_04/data/models/user_model.dart';
import 'package:assignment_04/data/service/network_caller.dart';
import 'package:assignment_04/data/utils.dart';
import 'package:assignment_04/ui/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {

  bool _inProgress = false;
  String? _errorMessage;

  // Getter
  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;


  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, String> requestBody = {
      'email' : email,
      'password' : password
    };
    NetworkResponse response = await NetworkCaller.postRequest(url: Urls.loginUrl, body: requestBody, isFromLogin: true);

    if(response.isSuccess){
      UserModel userModel = UserModel.fromJson(response.body!['data']);
      String token = response.body!['token'];

      await AuthController.saveUserData(userModel, token);
      isSuccess = true;
      _errorMessage = null;

    } else {
      _errorMessage = response.errorMessage!;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}