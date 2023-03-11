import 'package:flutter/material.dart';
import 'package:nfo/common/constant_theme.dart';
import 'package:nfo/screen/login_screen.dart';
import 'package:nfo/service/auth_service.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstantTheme.background,
      child: ElevatedButton(onPressed: () {
        logout();
        Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) =>
              const LoginScreen(),
              fullscreenDialog: true),
        );
      },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)
            )),
            backgroundColor: MaterialStateProperty.all(ConstantTheme.nearlyBlue),
            padding: MaterialStateProperty.all(const EdgeInsets.only(left: 32, right: 32, top: 12, bottom: 12)),
          ),
          child: const Text("Đăng xuất", style: TextStyle(fontSize: 18, ),)),
    );
  }
}
