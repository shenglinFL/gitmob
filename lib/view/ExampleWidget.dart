import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:amap_location/amap_location.dart';

class ExampleWidget extends StatefulWidget {
  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {

  AMapLocation _loc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AMapLocationClient.setApiKey("19a363cdaf2ee5d017b084262939c95d");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemExtent: 40.0,
        itemBuilder: (BuildContext content, int index) {
          var text = "无";
          switch (index) {
            case 0:
              text = "webviewWidget";
              break;
            case 1:
              text = _loc == null ? "高德地图" : "定位成功: ${_loc.formattedAddress}";
              break;
            default:
          }
          return Center(
            child: CupertinoButton(child: Text(text), onPressed: () {
              clickList(index);
            }),
          );
        },
        itemCount: 10,
      ),
    );
  }
  

  clickList(int index) async {
    switch (index) {
      case 0:
        break;
      case 1:
        bool isStated = await AMapLocationClient.startup(new AMapLocationOption( desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters  ));
        AMapLocation location = await AMapLocationClient.getLocation(true);
        print("Location: ${location.formattedAddress}");
        setState(() {
          _loc = location;
        });
        break;
      default:
        break;
    }
  }
}
