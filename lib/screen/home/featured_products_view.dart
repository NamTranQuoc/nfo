import 'package:flutter/material.dart';
import 'package:nfo/entity/product_type.dart';
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

    // Product product1 = Product(images: ["https://firebasestorage.googleapis.com/v0/b/nfo-app-8dc6d.appspot.com/o/product%2F1.png?alt=media&token=512dbaed-b112-4789-9387-9ad5eec37f4d", "https://firebasestorage.googleapis.com/v0/b/nfo-app-8dc6d.appspot.com/o/product%2F2.png?alt=media&token=b42c0a15-1ff4-4afc-a353-8a629b4a3f4b"],
    //     types: [ProductType(
    //         name: 'Silver',
    //         price: 28000000,
    //         quantity: 2
    //     ),
    //       ProductType(
    //           name: "Space Gray",
    //           price: 28500000,
    //           quantity: 3
    //       )],
    //     createdDate: DateTime.now(),
    //     name: 'Apple MacBook Air (2020) M1 Chip, 13.3-inch, 8GB, 256GB SSD',
    //     evaluate: 4.9,
    //     description: 'Tính năng nổi bật\n • Chip M1 do Apple thiết kế tạo ra một cú nhảy vọt về hiệu năng máy học, CPU và GPU\n • Tăng thời gian sử dụng với thời lượng pin lên đến 18 giờ1\n • CPU 8 lõi cho tốc độ nhanh hơn đến 3.5x, xử lý công việc nhanh chóng hơn bao giờ hết 2\n • GPU lên đến 8 lõi với tốc độ xử lý đồ họa nhanh hơn đến 5x cho các ứng dụng và game đồ họa khủng2\n • Neural Engine 16 lõi cho công nghệ máy học hiện đại\n • Bộ nhớ thống nhất 8GB giúp bạn làm việc gì cũng nhanh chóng và trôi chảy\n • Ổ lưu trữ SSD siêu nhanh giúp mở các ứng dụng và tập tin chỉ trong tích tắc\n • Thiết kế không quạt giảm tối đa tiếng ồn khi sử dụng\n • Màn hình Retina 13.3 inch với dải màu rộng P3 cho hình ảnh sống động và chi tiết ấn tượng3\n • Camera FaceTime HD với bộ xử lý tín hiệu hình ảnh tiên tiến cho các cuộc gọi video đẹp hình, rõ tiếng hơn\n • Bộ ba micro phối hợp tập trung thu giọng nói của bạn, không thu tạp âm môi trường\n • Wi-Fi 6 thế hệ mới giúp kết nối nhanh hơn\n • Hai cổng Thunderbolt / USB 4 để sạc và kết nối phụ kiện\n • Bàn phím Magic Keyboard có đèn nền và Touch ID giúp mở khóa và thanh toán an toàn hơn\n • macOS Big Sur với thiết kế mới đầy táo bạo cùng nhiều cập nhật quan trọng cho các ứng dụng Safari, Messages và Maps',
    //     isFeatured: false);
    //
    // addProduct(product1);
    // print("a");
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
