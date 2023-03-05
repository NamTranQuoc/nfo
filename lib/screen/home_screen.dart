import 'package:flutter/material.dart';
import 'package:nfo/common/constant_theme.dart';
import 'package:nfo/screen/home/list_product_view.dart';

import 'home/category_view.dart';
import 'home/featured_products_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstantTheme.background,
      child: ListView(
        children: [
          getCategoryUI(),
          getFeaturedProducts(),
          getProducts()
        ],
      )
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Ngành hàng',
            textAlign: TextAlign.left,
            style: ConstantTheme.ts1,
          ),
        ),
        CategoryListView(
          callBack: () {},
        ),
      ],
    );
  }

  Widget getFeaturedProducts() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Nổi bật',
            textAlign: TextAlign.left,
            style: ConstantTheme.ts1,
          ),
        ),
        FeaturedProductsView(
          callBack: () {},
        ),
      ],
    );
  }

  Widget getProducts() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Sản Phẩm',
            textAlign: TextAlign.left,
            style: ConstantTheme.ts1,
          ),
        ),
        ListProductView(
          callBack: () {},
        ),
      ],
    );
  }
}
