import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    await user!.sendEmailVerification();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.greenAccent,
        content: Text(
          "Verification Email has been sent",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(children: [
        Text(
          "User ID $uid",
          style: const TextStyle(fontSize: 18.0),
        ),
        Row(
          children: [
            Text(
              "Email: $email",
              style: const TextStyle(fontSize: 18.0),
            ),
            user!.emailVerified
                ? const Text("Verifed")
                : TextButton(
                    onPressed: () => {
                          verifyEmail(),
                        },
                    child: const Text("Verify Email"))
          ],
        ),
        Text(
          "Create $creationTime",
          style: const TextStyle(fontSize: 18.0),
        ),
      ]),
    );
  }
}
