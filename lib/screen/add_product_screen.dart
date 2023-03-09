import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nfo/common/constant_theme.dart';
import 'package:nfo/common/my_image_picker.dart';
import 'package:nfo/common/storage.dart';

import '../common/common_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> imageFiles = [];
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
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
                    listImage(widthImage),
                    textField("Tên sản phẩm", name, type: TextInputType.text),
                    textField("Giá bán", price, type: TextInputType.number),
                    textField("Số lượng", quantity, type: TextInputType.number),
                    textField("Mô tả", description, type: TextInputType.multiline, maxLine: 4),
                    // multiSelectField("Ngành hàng", widget._categories, selected, setCategory)
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
                        print(value);
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
      return RaisedButton(
        color: ConstantTheme.nearlyBlue,
        onPressed: () {
          _getFromGallery();
        },
        child: Text("Chọn hình ảnh"),
      );
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
    widgets.add(RaisedButton(
      color: ConstantTheme.nearlyBlue,
      onPressed: () {
        _getFromGallery();
      },
      child: Text("Chọn hình ảnh", style: TextStyle(color: ConstantTheme.nearlyWhite),),
    ));
    return widgets;
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
}
