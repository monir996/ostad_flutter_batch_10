import 'package:assignment_04/app.dart';
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
            CircleAvatar(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Abdullah', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
                  Text('abdullah@gmail.com', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white))
                ],
              ),
            ),
            IconButton(onPressed: _onTapLogoutButton, icon: Icon(Icons.logout, color: Colors.white))
          ],
        ),
      ),
    );
  }

  void _onTapLogoutButton(){
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=> false);
  }

  void _onTapProfileBar(){
    if(ModalRoute.of(context)!.settings.name != UpdateProfileScreen.name){
      Navigator.pushNamed(context, UpdateProfileScreen.name);
    }
  }
}