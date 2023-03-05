import 'package:flutter/material.dart';
import 'package:nfo/common/constant_theme.dart';

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
      child: const Text("Thông tin cá nhân")
    );
  }
}
