import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_introduce/index/model.dart';
import 'package:flutter_introduce/utils/show_code.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_introduce/utils/utils_function.dart';
import 'package:flutter_introduce/main/caching_key/caching_key.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收藏"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.code),
            onPressed: () => showCode(context, "lib/main/system/favorite.dart"),
          )
        ],
      ),
      body: FavoriteBody(),
    );
  }
}

class FavoriteBody extends StatefulWidget {
  FavoriteBody({Key key}) : super(key: key);

  @override
  _FavoriteBodyState createState() => _FavoriteBodyState();
}

class _FavoriteBodyState extends State<FavoriteBody> {
  SlidableController slidableController = SlidableController();
  List<Model> favoriteList = List<Model>();
  double height = ScreenUtil().setHeight(30);

  @override
  void initState() {
    utilsGetData(CachingKey.favorite_key, 'string').then((val) {
      if (val != null) {
        List list = json.decode(val);
        Data.allDataModel.forEach((item) {
          if (list.contains(item.name)) {
            favoriteList.add(item);
          }
        });
        if (mounted) setState(() {});
      }
    });
    Timer(Duration(seconds: 5), () {
      if (mounted){
        setState(() {
          height = 0;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        caveat(),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(5),
            ),
            child: ListView.builder(
              itemCount: Data.allDataModel.length,
              itemBuilder: (context, int index) {
                return getItem(Data.allDataModel[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget getItem(Model data) {
    return Slidable(
      controller: slidableController,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      secondaryActions: <Widget>[checkFavorite(data)],
      actions: <Widget>[checkFavorite(data)],
      child: Container(
        height: ScreenUtil().setHeight(50),
        margin: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(5),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(10),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black45.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                data.widget,
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Text(
                  data.name,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
              ],
            ),
            InkWell(
              child: Icon(favoriteList.contains(data)
                  ? Icons.favorite
                  : Icons.favorite_border),
              onTap: () {
                if (!favoriteList.contains(data)) {
                  favoriteList.add(data);
                } else {
                  favoriteList.remove(data);
                }
                List<String> names = List<String>();
                favoriteList.forEach((item) {
                  names.add(item.name);
                });
                utilsetData(CachingKey.favorite_key, json.encode(names));
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  InkWell checkFavorite(Model data) {
    return InkWell(
      child: Container(
        color: Colors.red,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(5),
        ),
        child: Icon(favoriteList.contains(data)
            ? Icons.favorite
            : Icons.favorite_border),
      ),
      onTap: () {
        if (!favoriteList.contains(data)) {
          favoriteList.add(data);
        } else {
          favoriteList.remove(data);
        }
        List<String> names = List<String>();
        favoriteList.forEach((item) {
          names.add(item.name);
        });
        utilsetData(CachingKey.favorite_key, json.encode(names));
        setState(() {});
      },
    );
  }

  AnimatedContainer caveat() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: double.infinity,
      height: ScreenUtil().setHeight(height),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(15),
      ),
      color: Theme.of(context).backgroundColor,
      child: Text(
        "友情提示：收藏的Widget只会存在于本机内存中",
        style: TextStyle(
          fontSize: ScreenUtil().setSp(14),
          fontWeight: FontWeight.w500,
          color: Colors.red,
        ),
      ),
    );
  }
}
