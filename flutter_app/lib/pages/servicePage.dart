
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/utils/ColorConstants.dart';



class ServicePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ServicePage();
  }
}

class _ServicePage extends State<ServicePage> {

  List<Image> imageList = new List();

  @override
  void initState(){
    super.initState();
    imageList.add(new Image.network(
      "http://hbimg.b0.upaiyun.com/a3e592c653ea46adfe1809e35cd7bc58508a6cb94307-aaO54C_fw658",
      fit: BoxFit.fill,
    ));
    imageList.add(new Image.network(
      "https://www.baidu.com/img/bd_logo1.png?where=super",
      fit: BoxFit.fill,
    ));
    imageList.add(new Image.network(
      "http://hbimg.b0.upaiyun.com/a3e592c653ea46adfe1809e35cd7bc58508a6cb94307-aaO54C_fw658",
      fit: BoxFit.fill,
    ));
    imageList.add(new Image.network(
      "https://www.baidu.com/img/bd_logo1.png?where=super",
      fit: BoxFit.fill,
    ));
    imageList.add(new Image.network(
      "http://hbimg.b0.upaiyun.com/a3e592c653ea46adfe1809e35cd7bc58508a6cb94307-aaO54C_fw658",
      fit: BoxFit.fill,
    ));
    imageList.add(new Image.network(
      "https://www.baidu.com/img/bd_logo1.png?where=super",
      fit: BoxFit.fill,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle:true,
        title: Padding(padding: EdgeInsets.all(8.0),
            child: new Image.asset("images/service_title.png")
        ),
      ),
      body: Column(
        children: <Widget>[
          buildStyle1(),
          Container(
            child: Column(
              children: <Widget>[

              ],
            ),
            height: ScreenUtil.getInstance().setHeight(320),
            width: ScreenUtil.screenWidth,
            decoration: BoxDecoration(
              border:Border.all(color: ColorConstants.theme_text_color, style: BorderStyle.solid),
            ),
          )
        ],
      )
    );
  }


//定义轮播图组件
  Widget buildStyle1() {
    return Container(
      height: ScreenUtil.getInstance().setHeight(350),
      child: new Swiper(
        // 横向
        scrollDirection: Axis.horizontal,
        // 布局构建
        itemBuilder: (BuildContext context, int index) {
          return imageList[index];
        },
        //条目个数
        itemCount: imageList.length,
        // 自动翻页
        autoplay: true,
        // 分页指示
        pagination: buildSwiperPagination(),
        //点击事件
        onTap: (index) {
          print(" 点击 " + index.toString());
        },
        // 视窗比例
        viewportFraction: 1,
        // 布局方式
        //layout: SwiperLayout.STACK,
        // 用户进行操作时停止自动翻页
        autoplayDisableOnInteraction: true,
        // 无线轮播
        loop: true,
        scale: 1,
      ),
    );
  }

}


//自定圆点分页指示器
buildSwiperPagination() {
  // 分页指示器
  return SwiperPagination(
    //指示器显示的位置
    alignment: Alignment.bottomCenter, // 位置 Alignment.bottomCenter 底部中间
    // 距离调整
    margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
    // 指示器构建
    builder: DotSwiperPaginationBuilder(
      // 点之间的间隔
        space: 2,
        // 没选中时的大小
        size: 6,
        // 选中时的大小
        activeSize: 12,
        // 没选中时的颜色
        color: Colors.black54,
        //选中时的颜色
        activeColor: Colors.white),
  );
}

