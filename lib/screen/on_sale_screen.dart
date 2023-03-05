import 'package:flutter/material.dart';
import 'package:nfo/common/constant_theme.dart';

class OnSaleScreen extends StatefulWidget {
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  _OnSaleScreenState createState() => _OnSaleScreenState();
}

class _OnSaleScreenState extends State<OnSaleScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstantTheme.background,
      child: const Text("Đang bán")
    );
  }
}
