import 'package:flutter/material.dart';
import 'package:nfo/entity/product.dart';
import 'package:nfo/repository/product_repository.dart';
import 'package:nfo/screen/home/product_view.dart';

import 'featured_product_view.dart';

class ListProductView extends StatefulWidget {
  const ListProductView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;

  @override
  _ListProductViewState createState() => _ListProductViewState();
}

class _ListProductViewState extends State<ListProductView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
        child: SizedBox(
          height: 655,
          child: FutureBuilder<List<Product>>(
            future: getAllProduct(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text("chờ tí đi...");
              } else {
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 32.0,
                    crossAxisSpacing: 32.0,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animationController!,
                            curve: Interval((1 / snapshot.data!.length) * index, 1.0,
                                curve: Curves.fastOutSlowIn)));
                    animationController?.forward();
                    return ProductView(
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
        )
    );
  }
}
