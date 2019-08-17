import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/httpRequest.dart';

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFadeTest(title: '个人中心'),
    );
  }
}

class MyFadeTest extends StatefulWidget {
  MyFadeTest({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyFadeTest createState() => _MyFadeTest();
}

class _MyFadeTest extends State<MyFadeTest> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;
  int _selectedIndex = 2;
  var tabImages;
  var appBarTitles = ['服务', '消息', '找货', '我的'];
  File _image;
  get onPressed => null;
  SharedPreferences prefs;
  String name;

  @override
  void initState() {
    initPrefs();
  }

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    // setState(() {
    name = prefs.getString('userName');
    // });
  }

  @override
  Widget build(BuildContext context) {
    tabImages = [
      [
        getTabImage('images/footer_ico1_off.png'),
        getTabImage('images/footer_ico1_on.png')
      ],
      [
        getTabImage('images/footer_ico2_off.png'),
        getTabImage('images/footer_ico1_on.png')
      ],
      [
        getTabImage('images/footer_ico3_off.png'),
        getTabImage('images/footer_ico1_on.png')
      ],
      [
        getTabImage('images/footer_ico4_off.png'),
        getTabImage('images/footer_ico1_on.png')
      ],
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new FlatButton(
            child: new Text(
              '设置',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            onPressed: _pushSaved,
            textColor: Colors.white,
            color: Colors.transparent,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              Container(
                child: new Image.asset('images/wd_info_bg.png'),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 230.0 / 750.0,
                // color: Colors.red,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'images/login_logo.png',
                      width: 66,
                      height: 25,
                    ),
                    IconButton(
                      icon: _image == null
                          ? (prefs == null
                              ? Image.asset('images/wd_header_img.png')
                              : Image.network(prefs.getString('userPicture')))
                          : Image.file(_image),
                      iconSize: 45,
                      onPressed: _getPhoneImage,
                    ),
                    Text(
                      name ?? '名称',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 230.0 / 750.0,
                // color: Colors.red,
              ),
            ],
          ),
          new Container(
            child: new GridView.builder(
              padding: const EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return buildItem(index);
              },
            ),
            width: MediaQuery.of(context).size.width,
            height: 500,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(title: getTabTitle(0), icon: getTabIcon(0)),
          BottomNavigationBarItem(title: getTabTitle(1), icon: getTabIcon(1)),
          BottomNavigationBarItem(title: getTabTitle(2), icon: getTabIcon(2)),
          BottomNavigationBarItem(title: getTabTitle(3), icon: getTabIcon(3)),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _pushSaved() {}

  buildItem(num index) {
    List list1 = new List();
    list1.add('images/wd_menu_ico1.png');
    list1.add('images/wd_menu_ico2.png');
    list1.add('images/wd_menu_ico3.png');
    list1.add('images/wd_menu_ico4.png');
    list1.add('images/wd_menu_ico5.png');
    list1.add('images/wd_menu_ico6.png');
    list1.add('images/wd_menu_ico7.png');
    list1.add('images/wd_menu_ico8.png');
    list1.add('images/wd_menu_ico9.png');

    return new GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Scaffold(
                      appBar: new AppBar(
                        title: new Text('图片详情'),
                      ),
                      body: new Center(
                          child: new Container(
                        width: 300.0,
                      )),
                    )));
      },
      child: Container(
        child: new Image.asset(
          list1[index],
          // fit: BoxFit.contain,
        ),
        padding: const EdgeInsets.all(30.0),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _selectedIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _selectedIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: const Color(0xff1296db)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: Colors.black));
    }
  }

  Image getTabImage(path) {
    return new Image.asset(path, width: 24.0, height: 24.0);
  }

  Future _getPhoneImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      HttpRequestClient.getInstance().uploadImage(image).then((response) async {
        print('测试: ${response.data}');
        Map map1 = jsonDecode(response.data);
        Map content = map1['content'];

        _uploadHeadImage(content['flowId'], content['picFullUrl']);
      });
    });
  }

  Future _uploadHeadImage(String flowId, String picFullUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map map1 = {
      'userId': prefs.getString('userId') ?? '',
      'userPrice': flowId,
      'userPriceUrl': picFullUrl,
    };

    HttpRequestClient.getInstance().post('10025', map1).then((response) async {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}
