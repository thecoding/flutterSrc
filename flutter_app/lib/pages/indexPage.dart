

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'servicePage.dart';
import 'messagePage.dart';
import 'businessPage.dart';
import 'homePage.dart';


/*
 * 导航
 */
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}


class _IndexPageState extends State<IndexPage> {

  static final _bottomNavigationDefaultColor = Colors.black;
  static final _bottomNavigationChoiseColor = Colors.blue;
  List<Widget> pages = List<Widget>();// 界面中间部分
  int _currentIndex = 0; //当前选择

  static var titles = ['服务','消息','找货','我的'];
  var defaultIcon = ['images/index/service1.png','images/index/message1.png','images/index/order1.png','images/index/home1.png'];
  var choiseIcon  = ['images/index/service2.png','images/index/message2.png','images/index/order2.png','images/index/home2.png'];

  List<BottomNavigationBarItem> itemList = new List(titles.length);
  List<BottomNavigationBarItem> createItemList(){
    for(var i=0;i<titles.length;i++){
      var imageFile = _currentIndex == i ? choiseIcon[i] : defaultIcon[i];
      BottomNavigationBarItem item = BottomNavigationBarItem(
        title: new Text(titles[i],style: TextStyle(color: _currentIndex == i ? _bottomNavigationChoiseColor : _bottomNavigationDefaultColor)),
        icon: new Image.asset(imageFile, width: 24.0, height: 24.0)
      );
      itemList[i] = item;
    }
    return itemList;
  }
  

  @override
  void initState() {
    super.initState();
    pages.add(ServicePage());
    pages.add(MessagePage());
    pages.add(BusinessPage());
    pages.add(HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: createItemList(),
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },),
    );
  }
}

