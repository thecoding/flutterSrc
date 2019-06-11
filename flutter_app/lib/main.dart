import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "demo",
        home: new SafeArea(
          top: true,
          child: new Container(
            decoration: BoxDecoration(
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
                  padding: EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 50.0),
                  decoration: BoxDecoration(
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
                        decoration: BoxDecoration(color: Color.fromRGBO(88, 154, 219,1)),
                        child: new TextField(
                          decoration: InputDecoration(
                              hintText: "111111",
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      new Container(
                        width: 250.0,
                        child: Divider(height:0.7,indent:0.0,color: Color.fromRGBO(111, 168, 223,1)),
                      ),
                      new Container(
                        decoration: BoxDecoration(color: Color.fromRGBO(88, 154, 219,1)),
                        child: new TextField(
                          decoration: InputDecoration(
                              hintText: "111111",
                              border: InputBorder.none
                          ),
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
    print("方法已执行__");
  }

  void _codeChoose() {
    setState(() {
      pwdColor = Colors.white;
      codeColor = Color.fromRGBO(8, 109, 202, 1);
      isPwdLogin = false;
    });
  }
}
