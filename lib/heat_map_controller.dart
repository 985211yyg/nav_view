import 'package:flutter/services.dart';

class HeatMapController {
  MethodChannel heatMapChannel;

  // 工厂模式
  factory HeatMapController() => _getInstance();

  static HeatMapController get instance => _getInstance();
  static HeatMapController _instance;

  HeatMapController._internal() {
    // 初始化
  }

  static HeatMapController _getInstance() {
    if (_instance == null) {
      _instance = new HeatMapController._internal();
    }
    return _instance;
  }

  void initView(int viewId) {
    heatMapChannel =
        MethodChannel("com.reemii.heat_map.channel/" + viewId.toString());
  }

  void setLatLngs(String data) {
    heatMapChannel.invokeMethod("init", data);
  }
}
