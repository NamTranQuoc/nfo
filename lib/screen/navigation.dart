import 'package:flutter/material.dart';
import 'package:nfo/component/search.dart';
import 'package:nfo/screen/auction_screen.dart';
import 'package:nfo/screen/on_sale_screen.dart';
import 'package:nfo/screen/personal_info_screen.dart';
import 'package:nfo/common/constant_theme.dart';

import '../component/bottom_bar_view.dart';
import '../domain/tabIcon_data.dart';
import 'add_product_screen.dart';
import 'home_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: ConstantTheme.background,
  );

  Widget appbar = const SizedBox();

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = const HomeScreen();
    appbar = const Search();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstantTheme.background,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ConstantTheme.background,
          elevation: 0,
          title: appbar,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.only(top: 10),
          child: Stack(
            children: <Widget>[
              tabBody,
              bottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) =>
                      const AddProductScreen(),
                  fullscreenDialog: true),
            );
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = const HomeScreen();
                  appbar = const Search();
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = const AuctionScreen();
                  appbar = const Text('?????u gi?? hi???n t???i');
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = const OnSaleScreen();
                  appbar = const Text('B???n ??ang b??n');
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = const PersonalInfoScreen();
                  appbar = const Text('Th??ng tin c?? nh??n');
                });
              });
            }
          },
        ),
      ],
    );
  }
}
