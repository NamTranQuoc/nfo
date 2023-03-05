
import 'package:flutter/material.dart';
import 'package:nfo/entity/category.dart';
import 'package:nfo/repository/category_repository.dart';
import 'package:nfo/common/constant_theme.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Category categorySelect = Category(id: "-1", name: "");

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Widget getButtonUI(Category category) {
    bool isSelected = false;
    if (categorySelect.id == category.id) {
      isSelected = true;
    }
    return Container(
      margin: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          color: isSelected
              ? ConstantTheme.c3
              : ConstantTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          border: Border.all(color: ConstantTheme.c3)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white24,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          onTap: () {
            setState(() {
              if (categorySelect.id == category.id) {
                categorySelect = Category(id: "-1", name: "");
              } else {
                categorySelect = category;
              }
            });
          },
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 18, right: 18),
            child: Center(
              child: Text(
                category.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.27,
                  color: isSelected
                      ? ConstantTheme.nearlyWhite
                      : ConstantTheme.c3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: FutureBuilder<List<Category>>(
          future: getAllCategory(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("chờ tí đi...");
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
                itemCount: snapshot.data?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return getButtonUI(snapshot.data![index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
