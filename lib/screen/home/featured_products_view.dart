import 'package:flutter/material.dart';
import 'package:nfo/repository/product_repository.dart';

import '../../entity/product.dart';
import 'featured_product_view.dart';

class FeaturedProductsView extends StatefulWidget {
  const FeaturedProductsView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;

  @override
  _FeaturedProductsViewState createState() => _FeaturedProductsViewState();
}

class _FeaturedProductsViewState extends State<FeaturedProductsView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: SizedBox(
        height: 134,
        width: double.infinity,
        child: FutureBuilder<List<Product>>(
          future: getFeaturedProduct(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("chờ tí đi...");
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / snapshot.data!.length) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return FeaturedProductView(
                    product: snapshot.data![index],
                    animation: animation,
                    animationController: animationController,
                    callback: widget.callBack,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
