import 'dart:convert';
import 'dart:typed_data';

import 'package:assignment_04/data/models/user_model.dart';
import 'package:assignment_04/data/service/network_caller.dart';
import 'package:assignment_04/data/utils.dart';
import 'package:assignment_04/ui/controllers/auth_controller.dart';
import 'package:assignment_04/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:assignment_04/ui/widgets/common_appbar.dart';
import 'package:assignment_04/ui/widgets/screen_background.dart';
import 'package:assignment_04/ui/widgets/snackbar_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name = '/update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController =
      TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.userModel?.email ?? '';
    _firstNameTEController.text = AuthController.userModel?.firstName ?? '';
    _lastNameTEController.text = AuthController.userModel?.lastName ?? '';
    _phoneNumberTEController.text = AuthController.userModel?.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),

            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),

                  _buildPhotoPicker(),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    enabled: false,
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _firstNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _phoneNumberTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Phone Number'),
                    validator: (String? value) {
                      int length = value?.length ?? 0;

                      if (length > 0 && length <= 6) {
                        return 'Enter your phone number';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if ((value?.length ?? 0) <= 6) {
                        return 'Enter a valid password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  Visibility(
                    visible: _updateProfileInProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Text(
                'Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _selectedImage == null ? 'Select Image' : _selectedImage!.name,
              maxLines: 1,
              style: TextStyle(
                color: Colors.black54,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapPhotoPicker() async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      _selectedImage = pickedImage;
      setState(() {});
    }
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    Uint8List? imageBytes;

    _updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, String> requestBody = {
      'email': _emailTEController.text,
      'firstName': _firstNameTEController.text.trim(),
      'lastName': _lastNameTEController.text.trim(),
      'mobile': _phoneNumberTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }

    if (_selectedImage != null) {
      imageBytes = await _selectedImage!.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes);
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );

    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      UserModel userModel = UserModel(
        id: AuthController.userModel!.id,
        email: _emailTEController.text,
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        phoneNumber: _phoneNumberTEController.text.trim(),
        photo: imageBytes == null ? AuthController.userModel?.photo : base64Encode(imageBytes),
      );
      await AuthController.updateUserData(userModel);
      _passwordTEController.clear();
      if (mounted) {
        showSnackBarMessage(context, 'Profile updated.');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneNumberTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
