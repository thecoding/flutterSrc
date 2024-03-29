import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/UserCenter.dart';
import 'package:flutter_app/httpRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//
import 'pages/indexPage.dart';

void main() => runApp(new MyApp());

const chooseColor = Color.fromRGBO(8, 109, 202, 1); //字段选中颜色
const fontColor = Colors.white; //字段默认颜色
const buttonBackColor = Color.fromRGBO(111, 168, 223, 1); //密码登陆 或 验证码登陆 按钮背景颜色
const inputBackColor = Color.fromRGBO(88, 154, 219, 1); // 输入框背景颜色

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new App(),
    );
  }
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  var isPwdLogin = true; // 密码登陆 或 验证码登陆 --> true 密码登陆   false  验证码登陆

  var hintStr = ""; //手机号码提示语
  var isShow = false; //手机号码提示语是否显示  false 显示  true 不显示

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  var _countdownTime = 0;

  Timer _timer;

  @override
  Widget build(BuildContext context) {

    //屏幕适配方案
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: false)..init(context);

    return MaterialApp(
        title: "demo",
        home: new SafeArea(
          top: false,
          bottom: false,
          child: new Container(
            decoration: BoxDecoration(
              //todo 测试边框
                border: Border.all(color: Colors.red, style: BorderStyle.solid),
                image: DecorationImage(
                  image: AssetImage('images/login_bg.png'),
                  fit: BoxFit.fill,
                )),
            child: new Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: new Container(
                  width: 300.0,
                  padding: EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 0.0),
                  decoration: BoxDecoration(
                    //todo 测试边框
                    border:
                    Border.all(color: Colors.red, style: BorderStyle.solid),
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Image(
                        image: AssetImage('images/login_logo.png'),
                        width: 150.0,
                        height: 100.0,
                      ),
                      new Row(
                        children: <Widget>[
                          Expanded(
                            child: new Container(
                              height: 40.0,
                              child: new RaisedButton(
                                onPressed: _pwdChoose,
                                child: new Text("密码登陆"),
                                color: buttonBackColor,
                                textColor: isPwdLogin ? chooseColor : fontColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5.0)),
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: new Container(
                              height: 40.0,
                              child: new RaisedButton(
                                onPressed: _codeChoose,
                                child: new Text("验证码登陆"),
                                color: buttonBackColor,
                                textColor:
                                !isPwdLogin ? chooseColor : fontColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5.0))),
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                      new Container(
                        width: 350.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: inputBackColor,
                          border: Border.all(
                              color: Colors.yellow, style: BorderStyle.solid),
                        ),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              padding: EdgeInsets.all(5.0),
                              child: iconAssetImage("images/tx.png"),
                              decoration: BoxDecoration(
                                //todo 测试边框
                                border: Border.all(
                                    color: Colors.red,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            new Container(
                              width: 150.0,
                              child: new TextField(
                                controller: phoneController,
                                //显示的文字内容为 下一步
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                //最大行数
                                maxLines: 1,
                                //最多字数
                                maxLength: 11,
                                //只能输入数字
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly,
                                ],
                                style: TextStyle(
                                    decorationStyle: TextDecorationStyle.solid),
                                decoration: InputDecoration(
                                  counterText: "", //此处控制最大字符是否显示  maxLength
                                  hintText: "请输入用户手机",
//                            border: InputBorder.none,

                                  //todo 测试边框
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.yellow,
                                          style: BorderStyle.solid)),
                                ),
                              ),
                            ),
                            phoneHintState(hintStr, isShow),
                          ],
                        ),
                      ),
                      new Container(
                        width: 250.0,
                        child: Divider(
                            height: 0.7, indent: 0.0, color: buttonBackColor),
                      ),
                      new Container(
                        width: 350.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: inputBackColor,
                          border: Border.all(
                              color: Colors.yellow, style: BorderStyle.solid),
                        ),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              padding: EdgeInsets.all(5.0),
                              child: iconAssetImage(isPwdLogin
                                  ? "images/pwd.png"
                                  : "images/star.png"),
                              decoration: BoxDecoration(
                                //todo 测试边框
                                border: Border.all(
                                    color: Colors.red,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            new Container(
                              width: 100.0,
                              child: new TextField(
                                controller: passController,
                                obscureText: true, //密码
                                //显示的文字内容为 下一步
                                textInputAction: TextInputAction.send,
                                //最大行数
                                maxLines: 1,
                                //最多字数
                                maxLength: 11,
                                style: TextStyle(
                                    decorationStyle: TextDecorationStyle.solid),
                                decoration: InputDecoration(
                                  counterText: "", //此处控制最大字符是否显示  maxLength
                                  hintText: isPwdLogin ? "请输入用户密码" : "请输入验证码",
                                  border: InputBorder.none,

                                  //todo 测试边框
//                                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow,style: BorderStyle.solid)),
                                ),
                              ),
                            ),
                            //控制显示隐藏
                            new Offstage(
                              offstage: false,
                              child: new Container(
                                width: 60.0,
                                child: new Text(
                                  "手机没注册",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 10.0),
                                ),
                                decoration: BoxDecoration(
                                  //todo 测试边框
                                  border: Border.all(
                                      color: Colors.red,
                                      style: BorderStyle.solid),
                                ),
                              ),
                            ),
                            new Offstage(
                              offstage: false,
                              child: new GestureDetector(
                                onTap: () {
                                  if (_countdownTime == 0 && validateMobile()) {
                                    setState(() {
                                      _countdownTime = 60;
                                    });
                                    //开始倒计时
                                    startCountdownTimer();
                                  }
                                },
                                child: new Text(
                                  _countdownTime > 0
                                      ? '$_countdownTime\s可重发'
                                      : '获取验证码',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.yellow,
                                      decorationStyle:
                                      TextDecorationStyle.solid,
                                      color: Colors.yellow),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        width: 300.0,
                        padding: EdgeInsets.only(top: 10.0),
                        child: new RaisedButton(
                          onPressed: _loginSubmit,
                          child: new Text("登陆"),
                          color: const Color.fromRGBO(79, 179, 93, 1),
                          textColor: fontColor,
                        ),
                      ),
                      new Container(
                        height: 40.0,
                        child: new Row(
                          children: <Widget>[
                            Expanded(
                              child: new GestureDetector(
                                onTap: _forgetPwd,
                                child: new Text(
                                  "忘记密码?",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: fontColor),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: new GestureDetector(
                                onTap: _freeRegister,
                                child: new Text(
                                  "免费注册",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: fontColor),
                                ),
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void _pwdChoose() {
    setState(() {
      isPwdLogin = true;
    });
    print("密码登陆");
  }

  void _codeChoose() {
    setState(() {
      isPwdLogin = false;
    });
    print("验证码登陆");
  }

  void _forgetPwd() {
    print("忘记密码");
  }

  void _freeRegister() {
    print("免费注册");
  }

  //  @"appOsVer":[NSString stringWithFormat:@"%@%@",systemName,systemVersion],
  //  @"appVerNo":Version,
  //  @"billId":self.loginType == PasswordType?self.textPhone1.text:self.textPhone2.text,
  //  @"eand":[Utils stringWithoutNil:longitude],
  //  @"loginType":[NSString stringWithFormat:@"%ld",(long)self.loginType],
  //  @"mobileBrand":@"IPhone",
  //  @"mobileType":model,
  //  @"nand":[Utils stringWithoutNil:latitude],
  //  @"pushAppId":pushAppId,
  //  @"pushChannelId":channelId,
  //  @"pushUserId":userId,
  //  @"pwd":self.loginType == PasswordType?[Utils base64Encrypt:self.password.text]:@"",
  //  @"sendCode":self.loginType == AuthCodeType?[Utils base64Encrypt:self.authCode.text]:@"",
  Future _loginSubmit() async {
        Navigator.push(context,new MaterialPageRoute(builder: (context) => new IndexPage()));

    // String password =
    // base64Encode(utf8.encode('12' + passController.text + '34{zx}'));
    // Map map2 = {
    //   'appOsVer': 'iOS12.2',
    //   'appVerNo': '1.6.3',
    //   'billId': phoneController.text,
    //   'eand': '113.170000',
    //   'loginType': '1',
    //   'mobileBrand': 'iPhone',
    //   'mobileType': 'iPhone',
    //   'nand': '23.800000',
    //   'pushAppId': '',
    //   'pushChannelId': '',
    //   'pushUserId': '',
    //   'pwd': password,
    //   'sendCode': '',
    // };

    // HttpRequestClient.getInstance().post('10007', map2).then((response) async {
    //   print("Response status: ${response.statusCode}");
    //   print("Response body: ${response.body}");
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   var body = jsonDecode(response.body);

    //   if (body['status'] == 200) {

    //     Map<String, Object> content = body['content'];
    //     prefs.setString('billId', content['billId']);
    //     prefs.setString('tenantId', content['tenantId']);
    //     prefs.setString('tokenId', content['tokenId']);
    //     prefs.setString('userId', content['userId']);
    //     prefs.setString('userName', content['userName']);
    //     prefs.setString('userPicture', content['userPicture']);

    //     Navigator.push(context,
    //         new MaterialPageRoute(builder: (BuildContext context) {
    //           return new SampleApp();
    //         }));
    //   }
    // });
  }

  // 手机号码错误提示
  // hintStr 提示语
  //isShow 是否显示控件  false 显示   true 不显示
  Widget phoneHintState(String hintStr, bool isShow) {
    return new Offstage(
      offstage: isShow,
      child: new Text(
        hintStr,
        style: TextStyle(color: Colors.red, fontSize: 12.0),
      ),
    );
  }

  Widget iconAssetImage(String imagePath) {
    return new Image(
      image: AssetImage(imagePath),
      width: 25.0,
      height: 25.0,
    );
  }

  //获取验证码
  void _getCode() {
    print("获取验证码..");
  }

  //验证手机号码
  bool validateMobile() {
    return true;
  }

  //开始倒计时
  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_countdownTime < 1) {
          _timer.cancel();
        } else {
          _countdownTime = _countdownTime - 1;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
