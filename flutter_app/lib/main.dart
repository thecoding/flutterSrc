import 'package:flutter/material.dart';

void main() => runApp(App());


class App extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App>{

  var pwdColor = Color.fromRGBO(8, 109, 202,1);
  var codeColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "demo",
      home: new Container(
        padding: EdgeInsets.fromLTRB(20.0, 120.0, 20.0, 50.0),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/login_bg.png'),
              fit: BoxFit.cover,
            )),
        child: new Column(
          children: <Widget>[
            new Image(
              image: AssetImage('images/login_logo.png'),
              width: 150.0,
              height: 100.0,
            ),
            new Container(
              width: 250.0,
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: new Container(
                      height: 40.0,
                      child: new RaisedButton(
                        onPressed: () => {},
                        child: new Text("密码登陆"),
                        color: const Color.fromRGBO(111, 168, 223,1),
                        textColor: Color.fromRGBO(8, 109, 202,1),
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
                        onPressed: () => {},
                        child: new Text("验证码登陆"),
                        color: const Color.fromRGBO(111, 168, 223,1),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(5.0))
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            new Container(
              width: 250.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Color.fromRGBO(88, 154, 219,1),
              ),
              child: new Row(
                children: <Widget>[
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          width: 40.0,
                          height: 40.0,
                          padding: EdgeInsets.fromLTRB(10.0,10.0,10.0,10.0),
                          child: new Image(
                            image: AssetImage('images/tx.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    _pwdChoose() {
      pwdColor = Color.fromRGBO(8, 109, 202,1);
      codeColor = Colors.white;
    }

    _codeChoose() {
      pwdColor = Colors.white;
      codeColor = Color.fromRGBO(8, 109, 202,1);
    }
  }
}



