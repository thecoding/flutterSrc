import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpRequestClient {
  static HttpRequestClient instance;
  static String httpUrl;
  static HttpRequestClient getInstance() {
    print('getInstance');
    if (instance == null) {
      instance = new HttpRequestClient();
    }
    return instance;
  }

  HttpRequestClient() {
    // httpUrl = 'http://pt.ghc98.com/intf';
    httpUrl = 'http://192.168.1.250:90/intf'; //内网测试
    // httpUrl = 'http://192.168.1.186:27007/intf'; //王哥电脑
  }

  Future<http.Response> post(String inCode, Map parameters) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var map1 = Map<String, Object>();
    map1['inCode'] = inCode;
    map1['netType'] = 'wifi';
    map1['appId'] = 'ios';
    map1['ver'] = '1.6.3';
    map1['uId'] = prefs.getString('userId') ?? '';
    map1['tokenId'] = prefs.getString('tokenId') ?? '';
    map1['content'] = parameters;

    num time = new DateTime.now().millisecondsSinceEpoch;
    String time_str = (time / 1000).toStringAsFixed(0);

    var random = Random();
    String randomStr = random.nextInt(2147483647).toString(); //random uint32

    String json_str = jsonEncode(parameters);

    List list2 = new List();
    list2.add(prefs.getString('tokenId') ?? '');
    list2.add(time_str);
    list2.add(randomStr);
    list2.add(json_str);

    list2.add('3KDD4t4167DBF45F97DBF4567DBF45F4'); //测试
    // list2.add('DBF45F97DBF3KDD4t41674567DBF45F4');//生产

    //排序
    list2.sort((left, right) => Comparable.compare(left, right));

    String sort_str = list2.toString();
    var digest = sha1.convert(utf8.encode(sort_str));

    String sign = digest.toString();

    map1['time'] = time_str;
    map1['rd'] = randomStr;
    map1['sign'] = sign;

    // print('post请求启动! url：$httpUrl ,body: $parameters');
    // await http.post(httpUrl, body: jsonEncode(map1)).then((response) async {
    //   print("Response status: ${response.statusCode}");
    //   print("Response body: ${response.body}");
    //   return Future.value(response);
    // });

    http.Response response = await http.post(httpUrl, body: jsonEncode(map1));
    return Future.value(response);
  }

  //上传图片
  Future<Response> uploadImage(File imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var map1 = Map<String, Object>();
    var map2 = Map<String, Object>();
    map1['inCode'] = '11001';
    map1['netType'] = 'wifi';
    map1['appId'] = 'ios';
    map1['ver'] = '1.6.3';
    map1['uId'] = prefs.getString('userId') ?? '';
    map1['tokenId'] = prefs.getString('tokenId') ?? '';
    map1['content'] = map2;

    num time = new DateTime.now().millisecondsSinceEpoch;
    String time_str = (time / 1000).toStringAsFixed(0);

    var random = Random();
    String randomStr = random.nextInt(2147483647).toString(); //random uint32

    String json_str = jsonEncode(map2);

    List list2 = new List();
    list2.add(prefs.getString('tokenId') ?? '');
    list2.add(time_str);
    list2.add(randomStr);
    list2.add(json_str);

    list2.add('3KDD4t4167DBF45F97DBF4567DBF45F4'); //测试
    // list2.add('DBF45F97DBF3KDD4t41674567DBF45F4');//生产

    //排序
    list2.sort((left, right) => Comparable.compare(left, right));

    String sort_str = list2.toString();
    var digest = sha1.convert(utf8.encode(sort_str));

    String sign = digest.toString();

    map1['time'] = time_str;
    map1['rd'] = randomStr;
    map1['sign'] = sign;

    Dio dio = new Dio();
    // 配置dio实例
    dio.options.baseUrl = "http://192.168.1.250:90";
    dio.options.connectTimeout = 30000; //5s
    dio.options.receiveTimeout = 30000;
    dio.options.sendTimeout = 30000;
    FormData formData = new FormData.from({
      "json": jsonEncode(map1),
      "file": new UploadFileInfo(imageFile, "imageFile.png"),
    });
    Response response = await dio.post('/intf', data: formData);
    return Future.value(response);
    
  }
}
