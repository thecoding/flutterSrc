import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  var pwdColor = Color.fromRGBO(8, 109, 202, 1);
  var codeColor = Colors.white;
  var isPwdLogin = true;

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "demo",
        home: new SafeArea(
          top: true,
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
                    border: Border.all(color: Colors.red,style: BorderStyle.solid),
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
                                color: const Color.fromRGBO(111, 168, 223,1),
                                textColor: pwdColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0)),
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
                                color: const Color.fromRGBO(111, 168, 223,1),
                                textColor: codeColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(5.0))
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                      new Container(
                        width: 350.0,
                        height: 40.0,
                        decoration: BoxDecoration(color: Color.fromRGBO(88, 154, 219,1),
                            border: Border.all(color: Colors.yellow,style: BorderStyle.solid),
                        ),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              padding: EdgeInsets.all(5.0),
                              child: new Image(image: AssetImage("images/tx.png"),
                                width: 25.0,
                                height: 25.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red,style: BorderStyle.solid),
                              ),
                            ),
                            new Container(
                              width: 150.0,
                              child: new TextField(
                              controller: phoneController,
                              //显示的文字内容为 下一步
                              textInputAction: TextInputAction.next,
                              keyboardType:TextInputType.phone,
                              //最大行数
                              maxLines: 1,
                              //最多字数
                              maxLength: 11,
                              //只能输入数字
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(decorationStyle: TextDecorationStyle.solid),
                                decoration: InputDecoration(
                                counterText: "",//此处控制最大字符是否显示  maxLength
                                  hintText: "请输入用户手机",
//                            border: InputBorder.none,

                                //todo 测试边框
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow,style: BorderStyle.solid)),
                                ),
                              ),
                            ),
                            new Offstage(
                              offstage: false,
                              child: new Text("手机没注册",
                                style: TextStyle(color: Colors.red,fontSize: 12.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        width: 250.0,
                        child: Divider(height:0.7,indent:0.0,color: Color.fromRGBO(111, 168, 223,1)),
                      ),
                      new Container(
                        width: 350.0,
                        height: 40.0,
                        decoration: BoxDecoration(color: Color.fromRGBO(88, 154, 219,1),
                          border: Border.all(color: Colors.yellow,style: BorderStyle.solid),
                        ),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              padding: EdgeInsets.all(5.0),
                              child: new Image(image: AssetImage("images/pwd.png"),
                                width: 25.0,
                                height: 25.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red,style: BorderStyle.solid),
                              ),
                            ),
                            new Container(
                              width: 150.0,
                              child: new TextField(
                                controller: passController,
                                obscureText: true, //密码
                                //显示的文字内容为 下一步
                                textInputAction: TextInputAction.send,
                                //最大行数
                                maxLines: 1,
                                //最多字数
                                maxLength: 11,
                                style: TextStyle(decorationStyle: TextDecorationStyle.solid),
                                decoration: InputDecoration(
                                  counterText: "",//此处控制最大字符是否显示  maxLength
                                  hintText: "请输入用户密码",
//                                border: InputBorder.none,

                                  //todo 测试边框
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow,style: BorderStyle.solid)),
                                ),
                              ),
                            ),
                            //控制显示隐藏
                            new Offstage(
                              offstage: false,
                              child: new Text("手机没注册",
                                style: TextStyle(color: Colors.red,fontSize: 12.0),
                              ),
                            ),
                          ],
                        ),
                      ),
//                      new Container(
//                        decoration: BoxDecoration(color: Color.fromRGBO(88, 154, 219,1),borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0),bottomRight: Radius.circular(5.0))),
//                        child: new Offstage(
//                          offstage: false,
//                          child: new TextField(
//                            controller: passController,
//                            obscureText: true, //密码
//                            maxLength: 18,
//                            decoration: InputDecoration(
//                              counterText: "",//此处控制最大字符是否显示  maxLength
//                              hintText: "请输入用户密码",
//                              border: InputBorder.none,
//                              icon: new Container(child:Image.asset("images/pwd.png",width: 30.0,height: 30.0,),
//                                padding: EdgeInsets.only(left: 5.0,right: 5.0),
//                                decoration: BoxDecoration(
//                                  //todo 测试边框
//                                  border: Border.all(color: Colors.red,style: BorderStyle.solid),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
                      new Container(
                        width: 300.0,
                        padding: EdgeInsets.only(top: 10.0),
                        child: new RaisedButton(
                          onPressed: _loginSubmit,
                          child: new Text("登陆"),
                          color: const Color.fromRGBO(79, 179, 93,1),
                          textColor: Colors.white,
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
                                  "忘记密码",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.white),
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
                                  style: TextStyle(color: Colors.white),
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
      pwdColor = Color.fromRGBO(8, 109, 202, 1);
      codeColor = Colors.white;
      isPwdLogin = true;
    });
    print("密码登陆");
  }

  void _codeChoose() {
    setState(() {
      pwdColor = Colors.white;
      codeColor = Color.fromRGBO(8, 109, 202, 1);
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

  void _loginSubmit() {
    print("登陆...");
  }
}
