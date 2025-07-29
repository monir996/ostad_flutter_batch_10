import 'package:assignment_04/ui/screens/sign_in_screen.dart';
import 'package:assignment_04/ui/utils/asset_paths.dart';
import 'package:assignment_04/ui/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Center(child: SvgPicture.asset(AssetPaths.logoSvg))
      ),
    );
  }
}
