import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nfo/common/constant_theme.dart';
import 'package:nfo/common/storage.dart';

import '../common/common_widget.dart';
import '../entity/product.dart';
import '../entity/product_type.dart';
import '../repository/product_repository.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> imageFiles = [];
  List<ProductTypeController> types = [ProductTypeController()];
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController category = TextEditingController();
  List<dynamic> selected = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    double widthImage = (MediaQuery.of(context).size.width / 3) - 30;
    return Container(
      color: ConstantTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 16, right: 16),
                      child: Text(
                        'Hình ảnh',
                        textAlign: TextAlign.left,
                        style: ConstantTheme.ts2,
                      ),
                    ),
                    listImage(widthImage),
                    const Divider(
                      thickness: 2,
                      endIndent: 32,
                      indent: 32,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 16, right: 16),
                      child: Text(
                        'Thông tin chung',
                        textAlign: TextAlign.left,
                        style: ConstantTheme.ts2,
                      ),
                    ),
                    textField("Tên sản phẩm", name, type: TextInputType.text),
                    textField("Mô tả", description, type: TextInputType.multiline, maxLine: 4),
                    // multiSelectField("Ngành hàng", widget._categories, selected, setCategory)
                    const Divider(
                      thickness: 2,
                      endIndent: 32,
                      indent: 32,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 16, right: 16),
                      child: Text(
                        'Loại Sản phẩm',
                        textAlign: TextAlign.left,
                        style: ConstantTheme.ts2,
                      ),
                    ),
                    listType(widthImage)
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: ConstantTheme.nearlyBlue,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      uploadImages().then((value) {
                        Product product1 = Product(images: value,
                            types: types.map((e) {
                              return ProductType.fromController(e);
                            }).toList(),
                            createdDate: DateTime.now(),
                            name: name.text,
                            evaluate: 0.0,
                            description: description.text,
                            isFeatured: false);
                        addProduct(product1);
                      });
                    },
                    child: const Center(
                      child: Text(
                        'Thêm',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      )
    );
  }

  Future<List<String>> uploadImages() async {
    List<String> list = [];
    for (var element in imageFiles) {
      await uploadImage(element).then((value) {
        list.add(value);
      });
    }
    return list;
  }

  Widget listImage(double width) {
    if (imageFiles.isEmpty) {
      return buttonSelectImage();
    }
    return Column(
      children: buildImage(width),
    );
  }

  _getFromGallery() async {
    _picker.pickMultiImage().then((value) {
      if (value.isNotEmpty) {
        for (var element in value) {
          imageFiles.add(File(element.path));
          // uploadImage(File(element.path));
        }
        setState(() {});
      }
    }).onError((error, stackTrace) {
      print("error" + error.toString());
    });
  }

  List<Widget> buildImage(double width) {
    List<Widget> widgets = [];
    List<Widget> items = [];
    for (var element in imageFiles) {
      items.add(Container(
          width: width,
          height: width,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Colors.blueAccent)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.file(element),
            ))),
          );
      if (items.length == 3) {
        widgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ));
        items = [];
      }
    }if (items.length != 3) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      ));
      items = [];
    }
    widgets.add(buttonSelectImage());
    return widgets;
  }

  Widget buttonSelectImage() {
    return RaisedButton(
      color: ConstantTheme.nearlyBlue,
      onPressed: () {
        _getFromGallery();
      },
      child: const Text("Chọn hình ảnh",
        style: TextStyle(color: ConstantTheme.c6),),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: ConstantTheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Thêm sản phẩm',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }

  Widget listType(double width) {
    if (types.isEmpty) {
      return widgetAddAndRemoveType();
    }
    List<Widget> list = types.map((e) {
      return widgetType(e);
    }).toList();
    list.add(widgetAddAndRemoveType());
    return Column(
      children: list,
    );
  }

  Widget widgetAddAndRemoveType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RaisedButton(
          color: ConstantTheme.nearlyBlue,
          onPressed: () {
            _addType();
          },
          child: const Text("Thêm",
              style: TextStyle(color: ConstantTheme.c6)),
        ),
        const SizedBox(width: 10,),
        (types.length > 1) ? RaisedButton(
          color: ConstantTheme.nearlyRed,
          onPressed: () {
            _removeType();
          },
          child: const Text("Xoá",
              style: TextStyle(color: ConstantTheme.c6)),
        ) : const SizedBox()
      ],
    );
  }

  Widget widgetType(ProductTypeController productType) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          border: Border.all(color: ConstantTheme.c3),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: [
          textField("Tên loại", productType.name, type: TextInputType.text),
          textField("Giá", productType.price, type: TextInputType.number),
          textField("Số lượng", productType.quantity, type: TextInputType.number),
        ],
      ),
    );
  }

  _addType() {
    setState(() {
      types.add(ProductTypeController());
    });
  }

  _removeType() {
    setState(() {
      types.removeLast();
    });
  }
}
