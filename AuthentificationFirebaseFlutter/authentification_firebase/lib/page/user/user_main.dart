import 'package:authentification_firebase/page/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'change_password.dart';
import 'profile.dart';
import 'dashboard.dart';

class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int _SelectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    const Profile(),
    const ChangePassword(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _SelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Welcome User"),
            ElevatedButton(
              onPressed: (() async => {
                    await FirebaseAuth.instance.signOut(),
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                        (route) => false)
                  }),
              child: const Text("Logout"),
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
            )
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_SelectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "My Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Change Password"),
        ],
        currentIndex: _SelectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
