import 'package:assignment_04/ui/screens/canceled_task_list_screen.dart';
import 'package:assignment_04/ui/screens/completed_task_list_screen.dart';
import 'package:assignment_04/ui/screens/new_task_list_screen.dart';
import 'package:assignment_04/ui/screens/progress_task_list_screen.dart';
import 'package:assignment_04/ui/widgets/common_appbar.dart';
import 'package:flutter/material.dart';

class MainNavbarHolderScreen extends StatefulWidget {
  const MainNavbarHolderScreen({super.key});

  static const String name = '/main-navbar-holder';


  @override
  State<MainNavbarHolderScreen> createState() => _MainNavbarHolderScreenState();
}

class _MainNavbarHolderScreenState extends State<MainNavbarHolderScreen> {

  final List<Widget> _screens = [
    NewTaskListScreen(),
    ProgressTaskListScreen(),
    CompletedTaskListScreen(),
    CanceledTaskListScreen()
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CommonAppBar(),

      body: _screens[_selectedIndex],

      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index){
            _selectedIndex = index;
            setState(() {});
          },
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.new_label_outlined),
                label: 'New'
            ),
            NavigationDestination(
                icon: Icon(Icons.autorenew_outlined),
                label: 'Progress'
            ),
            NavigationDestination(
                icon: Icon(Icons.done_outline),
                label: 'Completed'
            ),
            NavigationDestination(
                icon: Icon(Icons.close_outlined),
                label: 'Canceled'
            ),
          ]
      ),
    );
  }
}


