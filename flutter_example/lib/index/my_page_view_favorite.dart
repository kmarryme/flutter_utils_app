import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_example/main/caching_key/caching_key.dart';
import 'package:flutter_example/utils/counter_model.dart';
import 'package:flutter_example/utils/custom_route.dart';
import 'package:flutter_example/utils/utils_function.dart';
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
              context.read<CounterModel>().changesSearchList([], false);
            },
          ),
        ),
        onChanged: (val) {
          if (val == null || val == "") {
            context.read<CounterModel>()..changesSearchList([], false);
          } else {
            List<Model> list = [];
            Data.allDataModel.forEach((item) {
              if (item.name.toLowerCase().contains(val.toLowerCase())) {
                list.add(item);
              }
            });
            context.read<CounterModel>()..changesSearchList(list, true);
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
  List<Model> showWidget = [];

  @override
  void initState() {
    super.initState();
    getFavorite();
    Future((){
      context.read<CounterModel>().changesSearchList([], false);
      // Provider.of<CounterModel>(context).changesSearchList([], false);
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
    bool isSearch = Provider.of<CounterModel>(context, listen: false).isSearch;
    List<Model> proList = Provider.of<CounterModel>(context, listen: false).searchList;
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
                    context.watch<CounterModel>().isSearch
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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(10),
                  ),
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 20,
                    children: (isSearch ? proList : showWidget).map((e) {
                      return Container(
                        width: 90,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: InkWell(
                                child: Container(
                                  width: 65,
                                  height: 65,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                    child: e.widget,
                                  ),
                                  onTap: () {
                                    int type = Random().nextInt(4);
                                    Navigator.push(
                                      context,
                                      CustomRoute(e.page, type),
                                    );
                                  },
                                ),
                              ),
                              Text(
                                "${e.name}",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        );
                      }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
