import 'dart:convert';

import 'package:assignment_04/ui/controllers/auth_controller.dart';
import 'package:assignment_04/ui/screens/sign_in_screen.dart';
import 'package:assignment_04/ui/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
  });

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: _onTapProfileBar,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AuthController.userModel!.photo == null ? null : MemoryImage(base64Decode(AuthController.userModel!.photo!)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AuthController.userModel!.fullName, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
                  Text(AuthController.userModel!.email, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white))
                ],
              ),
            ),
            IconButton(onPressed: _onTapLogoutButton, icon: Icon(Icons.logout, color: Colors.white))
          ],
        ),
      ),
    );
  }

  Future<void> _onTapLogoutButton() async{
    await AuthController.clearData();
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=> false);
  }

  void _onTapProfileBar(){
    if(ModalRoute.of(context)!.settings.name != UpdateProfileScreen.name){
      Navigator.pushNamed(context, UpdateProfileScreen.name);
    }
  }
}