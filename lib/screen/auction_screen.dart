import 'package:flutter/material.dart';
import 'package:nfo/common/constant_theme.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({Key? key}) : super(key: key);

  @override
  _AuctionScreenState createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstantTheme.background,
      child: const Text("Đấu giá")
    );
  }
}
