import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_introduce/main/caching_key/caching_key.dart';
import 'package:flutter_introduce/utils/counter_model.dart';
import 'package:flutter_introduce/utils/custom_route.dart';
import 'package:flutter_introduce/utils/utils_function.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class MyPageViewFavorite extends StatefulWidget {
  MyPageViewFavorite({Key key}) : super(key: key);

  @override
  _MyPageViewFavoriteState createState() => _MyPageViewFavoriteState();
}

class _MyPageViewFavoriteState extends State<MyPageViewFavorite>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Search(),
          FavoriteBody(),
        ],
      ),
    );
  }

}

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(10),
        horizontal: ScreenUtil().setWidth(10),
      ),
      height: kToolbarHeight,
      child: TextField(
        controller: controller,
        style: TextStyle(
          textBaseline: TextBaseline.alphabetic,
        ),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "搜索",
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color.withOpacity(0.5),
          ),
          suffixIcon: InkWell(
            child: Container(
              width: ScreenUtil().setWidth(20),
              alignment: Alignment.center,
              child: Icon(
                Icons.clear,
                color: Theme.of(context).iconTheme.color.withOpacity(0.5),
              ),
            ),
            onTap: () {
              Future(() => controller.clear());
              Provider.of<CounterModel>(context).changesSearchList([], false);
            },
          ),
        ),
        onChanged: (val) {
          if (val == null || val == "") {
            Provider.of<CounterModel>(context).changesSearchList([], false);
          } else {
            List<Model> list = List<Model>();
            Data.allDataModel.forEach((item) {
              if (item.name.toLowerCase().contains(val.toLowerCase())) {
                list.add(item);
              }
            });
            Provider.of<CounterModel>(context).changesSearchList(list, true);
          }
        },
      ),
    );
  }
}

class FavoriteBody extends StatefulWidget {
  FavoriteBody({Key key}) : super(key: key);

  @override
  _FavoriteBodyState createState() => _FavoriteBodyState();
}

class _FavoriteBodyState extends State<FavoriteBody> {
  List<Model> showWidget = List<Model>();

  @override
  void initState() {
    super.initState();
    getFavorite();
    Future((){
      Provider.of<CounterModel>(context).changesSearchList([], false);
    });
  }
  
  void getFavorite() async {
    showWidget.clear();
    utilsGetData(CachingKey.favorite_key, 'string').then((val) {
      if (val != null) {
        List list = json.decode(val);
        Data.allDataModel.forEach((item) {
          if (list.contains(item.name)) {
            showWidget.add(item);
          }
        });
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearch = Provider.of<CounterModel>(context).isSearch;
    List<Model> proList = Provider.of<CounterModel>(context).searchList;
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(10),
          vertical: ScreenUtil().setHeight(10),
        ),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
              ),
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(5),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    Provider.of<CounterModel>(context).isSearch
                        ? "搜索结果"
                        : "我的收藏",
                  ),
                  InkWell(
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).iconTheme.color.withOpacity(0.5),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/favorite").then((val) {
                        getFavorite();
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10),
                ),
                // physics: NeverScrollableScrollPhysics(),
                itemCount: isSearch ? proList.length : showWidget.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //横轴元素个数
                  crossAxisCount: 4,
                  //纵轴间距
                  mainAxisSpacing: 30.0,
                  //横轴间距
                  crossAxisSpacing: 0.0,
                  //子组件宽高长度比例
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            child: isSearch
                                ? proList[index].widget
                                : showWidget[index].widget,
                          ),
                          onTap: () {
                            int type = Random().nextInt(4);
                            Navigator.push(
                              context,
                              CustomRoute(Data.allDataModel[index].page, type),
                            );
                          },
                        ),
                      ),
                      Text(
                        isSearch
                            ? "${proList[index].name}"
                            : "${showWidget[index].name}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
