import 'package:flutter/material.dart';
import 'package:flutter_music_app/data/color.dart';
import 'package:flutter_music_app/data/data.dart';
import 'package:flutter_music_app/pages/library/widget/libraryHead.dart';
import 'package:flutter_music_app/pages/library/widget/libraryItem.dart';
import 'package:flutter_music_app/pages/library/widget/libraryListWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  late ScrollController _scroll_controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll_controller.addListener(() {});
  }

  @override
  void dispose() {
    _scroll_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double displayHeight = MediaQuery.of(context).size.height;
    Color currentPrimaryColor = Theme.of(context).primaryColor;

    return Scaffold(
        body: Container(
            color: Colors.black, // 设置背景颜色为黑色
            child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                controller: _scroll_controller,
                slivers: [
                  SliverPersistentHeader(
                    delegate: MySliverPersistentHeaderDelegate(),
                    pinned: true,
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return LibraryListWidget(index: index);
                      },
                      childCount: libraryData.length,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                    sliver: SliverToBoxAdapter(
                        child: Container(
                      height: 50,
                      child: Row(
                        children: [
                          const Text(
                            'Recentil Added',
                            style: TextStyle(
                                color: tFontColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'See all',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: tFontColor,
                                ),
                              ),
                              Icon(
                                FontAwesomeIcons.angleRight,
                                color: tFontColor,
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 列数
                        mainAxisSpacing: 15.0, // 纵轴间距
                        crossAxisSpacing: 15.0, // 横轴间距
                        childAspectRatio: 1.0, // 子项宽高比
                        mainAxisExtent: 254.0, // 纵轴方向上子项的最大高度
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return LibraryItemList(index: index);
                        },
                        childCount: library.length, // 网格中的子项数量
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 160),
                  )
                ])));
  }
}
