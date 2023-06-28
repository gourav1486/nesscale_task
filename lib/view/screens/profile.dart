import 'package:flutter/material.dart';
import 'package:nesscale_task/view/screens/home_page.dart';
import 'package:nesscale_task/view/screens/login.dart';
import 'package:nesscale_task/view/widgets/button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
            title: 'Logout',
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()))),
      ),
    );
  }
}
