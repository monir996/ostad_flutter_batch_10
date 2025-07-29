import 'package:assignment_04/ui/screens/pin_verification_screen.dart';
import 'package:assignment_04/ui/screens/sign_in_screen.dart';
import 'package:assignment_04/ui/widgets/screen_background.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const String name = '/change-password';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                  const SizedBox(height: 80),

                  Text('Set Password', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),

                  Text(
                      ' Password should be more than 6 letters',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value){

                      if((value?.length ?? 0) <= 6) {
                        return 'Enter a valid password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _confirmPasswordTEController,
                    decoration: InputDecoration(hintText: 'Confirm Password'),
                    validator: (String? value){

                      if((value ?? '') != _passwordTEController.text) {
                        return "Confirm password doesn't match";
                      }
                      return null;
                    },
                  ),


                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Text('Confirm'),
                  ),

                  const SizedBox(height: 32),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Have an account? ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
                            recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton
                          )
                        ]
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton (){
    // if(_formKey.currentState!.validate()){
    //   //TODO: Sign in with API
    // }
    Navigator.pushNamed(context, PinVerificationScreen.name);
  }


  void _onTapSignInButton (){
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
