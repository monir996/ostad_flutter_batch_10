import 'package:assignment_04/ui/screens/pin_verification_screen.dart';
import 'package:assignment_04/ui/widgets/screen_background.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  static const String name = '/forgot-password-email';

  @override
  State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {

  final TextEditingController _emailTEController = TextEditingController();
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

                  Text('Your Email Address', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),

                  Text(
                      ' A 6 digit otp will send to your email address',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value){
                      String email = value ?? '';

                      if(EmailValidator.validate(email) == false){
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),


                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
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
    _emailTEController.dispose();
    super.dispose();
  }
}
