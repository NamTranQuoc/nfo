import 'package:flutter/material.dart';
import 'package:nfo/common/constant_theme.dart';

import '../../common/parse.dart';
import '../../entity/product.dart';

class FeaturedProductView extends StatelessWidget {
  const FeaturedProductView(
      {Key? key,
      this.product,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Product? product;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                // Navigator.push<dynamic>(
                //   context,
                //   MaterialPageRoute<dynamic>(
                //     builder: (BuildContext context) => ProductInfoScreen(
                //       product: product,
                //     ),
                //   ),
                // );
              },
              child: SizedBox(
                width: 300,
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 48,
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: ConstantTheme.c6,
                              borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 48 + 24.0,
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Text(
                                          formatNameProduct(product!.name),
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            letterSpacing: 0.27,
                                            color:
                                                ConstantTheme.c5,
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16, bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            // Text(
                                            //   'Đã bán ${product!.numberOfSold}',
                                            //   textAlign: TextAlign.left,
                                            //   style: const TextStyle(
                                            //     fontWeight: FontWeight.w200,
                                            //     fontSize: 12,
                                            //     letterSpacing: 0.27,
                                            //     color:
                                            //         DesignCourseAppTheme.grey,
                                            //   ),
                                            // ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  '${product!.evaluate}',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 18,
                                                    letterSpacing: 0.27,
                                                    color: ConstantTheme.c4,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: ConstantTheme.c3,
                                                  size: 20,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 16, right: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              formatMoney(product!.types.first.price),
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                letterSpacing: 0.27,
                                                color: ConstantTheme.c3,
                                              ),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: ConstantTheme.c3,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.0)),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.add,
                                                  color: ConstantTheme.c1,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, bottom: 24, left: 16),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                                aspectRatio: 1.0,
                                child: Image.network(product!.images.first)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
